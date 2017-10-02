/**
 * @file   kernel.c
 *
 * @brief  entry point to the raspberry pi kernel
 *
 * @date   October 5, 2015
 * @author Nikhil Nilakantan <nnilakan@andrew.cmu.edu>
 * @author Karthic Palaniappan <kapalani@andrew.cmu.edu>
 */

#include <uart.h>
#include <printk.h>
#include <supervisor.h>
#include <leds.h>
#include <syscalls.h>
#include <adc_driver.h>
#include <arm.h>
#include <kstdint.h>
#include <timer.h>


/* Global variables for tasks */

/** @brief Statically allocated TCB blocks */
volatile tcb tcb_array[NUM_TASKS];
/** @brief an array of 32 integers that maps threads to 
 * their *actual* priorities (these change when threads acquire mutexes) 
 */
volatile int priority_map[NUM_TASKS];

/** @brief Index into tcb_array of currently running thread */
volatile uint32_t running_task_tcb_index = -1;

/** @brief runnable pool of threads */
volatile unsigned int runnable_pool;
/** @brief waiting pool of threads */
volatile unsigned int waiting_pool;
/** @brief global system time counter */
volatile unsigned int curr_time;

/** @brief Keeping track of whether thread is running for first time */
volatile int first_time_flag = 1;

/** @brief function that initializes the initial priority map and sets 
 * the alive and old priority fields of the tasks */
void initialize_priority_map() {
  int i;
  for (i = 0; i < NUM_TASKS; i++) {
    //initially same 1-1 mapping
    priority_map[i] = i;
    //no thread created yet
    tcb_array[i].alive = 0;
  }
}

/**
 * @brief The kernel entry point
 */
void kernel_main(void) {
  uart_init();
  adc_init();
  initialize_priority_map();
  install_interrupt_table();

  /* Clear interrupts and timer */
  disable_interrupts();
  timer_stop();

  enter_user_mode();
}

/**
 *  @brief Selects the next runnable task to be running from runnable pool
 *  Updates TCB array, runnable pool, and waiting pool to reflect
 *  task change. All priorities are put through a priority map before
 *  they are accessed from the tcb_array because priority map contains
 *  actual priorities that change when threads acquire mutexes
 */
void scheduler() {
  //currently a task is running
  if (running_task_tcb_index != -1) {
    volatile tcb* task = &(tcb_array[priority_map[running_task_tcb_index]]);
    //error checking but should never get here
    if (task->alive == 0) {
      printk("Invalid task \n");
      syscall_exit(1);
    }

    task->c_used++;

    /* Current task is waiting, so move it to the waiting pool and
     * set the next wakeup time
     */
    if (((task->c_used > task->c) &&
      (priority_map[running_task_tcb_index] != 31)) || 
      (task->state == WAITING)) {
      task->c_used = 0;
      waiting_pool |= (1<<task->priority);
      runnable_pool &= ~(1<<task->priority);
      unsigned int t = task->t;
      task->next_wakeup_time = (curr_time/t)*t + t;
      task->state = WAITING;
      //no task is currently running so set running_task_index to -1
      running_task_tcb_index = -1;
    }
  }
  
  //wake up tasks in waiting pool and add to runnable pool
  int i;
  for (i = 0; i < NUM_TASKS; i++) {
    if ((waiting_pool>>i) & 0x1) {
      /* No need for any indirection through priority map here 
       * because only want to wake up tasks that were created
       * (have their alive) field set
       */
      volatile tcb* task = &(tcb_array[i]);
      //task was created by user
      if (task->alive) {
        if (task->next_wakeup_time == curr_time) {
          waiting_pool &= ~(1<<task->priority);
          runnable_pool |= (1<<task->priority);
          task->state = RUNNABLE;
        }
      }
    }
  }
  
  //pick next runnable task
  int next_runnable_task_index = __builtin_ctz(runnable_pool);
  next_runnable_task_index = priority_map[next_runnable_task_index];
  
  /* no task currently running
   * DON'T REMOVE CURRENTLY RUNNING TASK FROM RUNNABLE POOL
   */
  if (running_task_tcb_index == -1) {
    volatile tcb* task = &(tcb_array[next_runnable_task_index]);
    task->state = RUNNING;
    task->c_used++;

    /* Set global running task index */
    running_task_tcb_index = next_runnable_task_index;
  }
  
  //higher priority task came in and preempted lower priority task
  else if (next_runnable_task_index < running_task_tcb_index) {
    volatile tcb* task = &(tcb_array[priority_map[running_task_tcb_index]]);
    task->state = RUNNABLE;
    
    task = &(tcb_array[priority_map[next_runnable_task_index]]);
    task->state = RUNNING;
    task->c_used++;
    
    /* Set global running task index */
    running_task_tcb_index = next_runnable_task_index;
  }
}

/**
 *  @brief Writes current context from IRQ stack into TCB context
 *  struct arrays
 *  Modifies IRQ stack in place
 *
 *  @
 args pointer to the saved context on the irq stack,
 *  saved by irq_asm_handler
 *
 *  @return ptr to the bottom of the saved context on the stack
 */
uint32_t *save_context(uint32_t *args) {
  uint32_t *ptr = args;
  volatile tcb* task = &(tcb_array[priority_map[running_task_tcb_index]]);
  /* Save context of running task into TCB */
  int i;
  for (i = 0; i < NUM_SPECIAL_REGS; i++) {
    task->ctx.special_regs[i] = *ptr;
    ptr++;
  }
  for (i = 0; i < NUM_COMMON_REGS; i++) {
    task->ctx.common_regs[i] = *ptr;
    ptr++;
  }
  /* Save link register  into TCB pc */
  task->pc = *ptr;
  return ptr;
}

/**
 *  @brief Writes new context from TCB context struct into IRQ stack
 *
 *  @param args pointer to the IRQ stack from where to write to
 *
 *  @return ptr to the top of the new restored context on the stack
 */
uint32_t *restore_context(uint32_t *args) {
  uint32_t *ptr = args;
  volatile tcb* task = &(tcb_array[priority_map[running_task_tcb_index]]);
  /* Restore context from new task's TCB into IRQ stack */
  int i;

  /* Restore TCB pc to link register address */
  *ptr = task->pc;
  ptr--;

  for (i = NUM_COMMON_REGS-1; i >= 0; i--) {
    *ptr = task->ctx.common_regs[i];
    ptr--;
  }
  for (i = NUM_SPECIAL_REGS-1; i >= 0; i--) {
    *ptr = task->ctx.special_regs[i];
    ptr--;
  }
  ptr++;
  return ptr;
}

/**
 * @brief Handler called when an IRQ occurs
 *
 * @param args pointer to the saved context on the stack,
 * saved by irq_asm_handler
 *
 * @return the context of the new running task
 */
uint32_t *irq_c_handler(uint32_t *args) {
  if (timer_is_pending()) {
    timer_clear_pending();
    uint32_t *ptr;
    curr_time ++;
    if (first_time_flag) {
      // Move ptr to context to the top of the context for overwrite 
      ptr = args + NUM_COMMON_REGS + NUM_SPECIAL_REGS;
      first_time_flag = 0;
    }
    else
      ptr = save_context(args);
    scheduler();
    return restore_context(ptr);
  }
  return args;
}


/**
 * @brief Handles the given swi_num
 *
 * @param swi_num the swi number passed in from swi_asm_handler
 * @param args pointer to arguments array, set up by the swi_asm_handler
 *
 * @return the return result of the syscall
 */
void *swi_c_handler(int swi_num, int *args) {
  switch (swi_num) {
    case 0:
      return (void *)syscall_sbrk(*args);
    case 1:
      return (void *)syscall_write(*args, (char *)*(args+1), *(args+2));
    case 2:
      return (void *)syscall_close(*args);
    case 3:
      return (void *)syscall_fstat(*args, (void *)*(args+1));
    case 4:
      return (void *)syscall_isatty(*args);
    case 5:
      return (void *)syscall_lseek(*args, *(args+1), *(args+2));
    case 6:
      return (void *)syscall_read(*args, (char *)*(args+1), *(args+2));
    case 7:
      syscall_exit(*args);
      break;
    case 8:
      return (void *)syscall_sample_adc_start(*args, (uint8_t)*(args+1),
        (void *)*(args+2));
    case 9:
      return (void *)syscall_sample_adc_stop();
    case 10:
      return (void*)syscall_thread_init((thread_fn)(*args),
        (uint32_t*)*(args+1));
    case 11:
      /* T is the 5th argument and by construction is passed in through
         r12, the scratch register */
      return (void*)syscall_thread_create((thread_fn)(*args),
        (uint32_t*)*(args+1),*(args+2), *(args+3),args[12]);
    case 12:
      return (void *)syscall_mutex_init((mutex_t *)(*args),*(args+1));
    case 13:
      syscall_mutex_lock((mutex_t *)(*args));
      return NULL;
    case 14:
      syscall_mutex_unlock((mutex_t *)(*args));
      return NULL;
    case 15:
      syscall_wait_until_next_period();
      return NULL;
    case 16:
      return (void*)syscall_get_time();
    case 17:
      return (void *)syscall_scheduler_start();
    default:
      break;
  }
  return NULL;
}
