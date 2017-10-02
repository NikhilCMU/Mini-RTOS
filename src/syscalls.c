/**
 * @file   syscalls.c
 *
 * @brief  Implementation of syscalls needed for newlib and 
 * 349 custom syscalls.
 * NOTE: This program also implemented nested mutexes. See comments
 * below for further details about implementation. lab3_test7 is a 
 * custom test that we wrote. It tests nested mutex implementation
 * by creating 3 mutexes and locking and unlocking them in different 
 * orders, It also supports the situation when all the mutexes have same
 * ceiling priority and tasks are created with the same priority. See
 * lab3_test7/src/main.c for further details
 *
 * @date   October 23, 2015
 * @author Nikhil Nilakantan <nnilakan@andrew.cmu.edu>
 * @author Karthic Palaniappan <kapalani@andrew.cmu.edu>
 */

#include <kstdint.h>
#include <printk.h>
#include <syscalls.h>
#include <arm.h>
#include <uart.h>
#include <timer.h>
#include <adc_driver.h>
#include <psr.h>

/** @brief Standard input file descriptor for read/write */
#define STDIN 0
/** @brief Standard output file descriptor for read/write */
#define STDOUT 1
/** @brief ASCII value for End of Transmission */
#define ASCII_EOT 4
/** @brief ASCII value for backspace */
#define ASCII_BACKSPACE 8
/** @brief ASCII value for delete */
#define ASCII_DELETE 127
/** @brief ASCII value for newline */
#define ASCII_NEWLINE 10
/** @brief ASCII value for carriage return */
#define ASCII_CARR_RETURN 13

/** @brief Idle TCB index*/
#define IDLE_TCB 31

/** @brief Global variable to keep track of where our heap ends */
char *heap_end = 0;

/** @brief Array of upper bounds for tasks */
float U[NUM_TASKS+1] = {0, 1.0, 0.8284, 0.7798, 0.7568, 0.7435, 0.7348, 
    0.7286, 0.7241, 0.7205, 0.7177, 0.7155, 0.7136, 0.712, 0.7106, 
    0.7094, 0.7084, 0.7075, 0.7067, 0.7059, 0.7053, 0.7047, 0.7042, 
    0.7037,0.7033, 0.7028, 0.7025, 0.7021, 0.7018, 0.7015, 0.7012, 
    0.701, 0.7007};


extern uint32_t running_task_tcb_index;
extern uint32_t curr_time;
extern tcb tcb_array[NUM_TASKS];
extern unsigned int runnable_pool, waiting_pool;
extern unsigned int curr_time;
extern int priority_map[NUM_TASKS];

/** @brief inline utility function to find minimum of 2 integers */
inline int min(int a,int b) {
  return (a<=b) ? a : b;
}

void syscall_exit(int status) {
  printk("Exit Status: %d\n", status);
  disable_interrupts();
  hang();
}


int syscall_write(int file, char *ptr, int len) {
  int count;

  if (file != STDOUT)
    return -1;

  for (count = 0; count < len; count ++) {
    if (!*ptr)
      return count;
    uart_put_byte(*ptr);
    ptr++;
  }

  return count;
}


/**
 * Reads until all len bytes are read or newline/return is found.
 * Detects backspace and EOL characters and handles them appropriately.
 *
 * The idea is to mimic normal terminal reading input, that is,
 * if the user hits backspace it should erase the 
 * previously read character.
 */
int syscall_read(int file, char *ptr, int len) {
  int count = 0;
  uint8_t read_byte;

  if (file != STDIN)
    return -1; //Kernel only supports STDIN

  while (count < len) {
    read_byte = uart_get_byte();

    if (read_byte == ASCII_EOT)
      return count;
    else if (read_byte == ASCII_BACKSPACE || read_byte == ASCII_DELETE) {
      // Guard against backspacing empty buffer
      if (count > 0) {
        count--;
        *(ptr+count) = NULL;
        printk("\b \b");
      }
      continue;
    }
    else if (read_byte == ASCII_NEWLINE || read_byte == ASCII_CARR_RETURN) {
      *(ptr+count) = read_byte;
      printk("\n");
      return count + 1;
    }

    *(ptr+count) = read_byte;
    uart_put_byte(read_byte);
    count++;
  }

  return count;
}

int syscall_sample_adc_start(int freq, uint8_t channel, void (*fn)(uint16_t)) {
  return 1;
}


int syscall_sample_adc_stop() {
  return 1;
}

/************************************************************************/
/* Thread/ Mutex System Call Implementation:                            */
/************************************************************************/

int syscall_thread_init(thread_fn idle_fn, uint32_t *idle_stack_start) {
  if ((idle_fn == NULL) || (idle_stack_start == NULL))
      return -1;
  tcb_array[IDLE_TCB].ctx.special_regs[USER_SP] = (uint32_t)idle_stack_start;
  tcb_array[IDLE_TCB].pc = (uint32_t)idle_fn;
  tcb_array[IDLE_TCB].c = 0;
  tcb_array[IDLE_TCB].t = 0;
  tcb_array[IDLE_TCB].ctx.special_regs[IRQ_SPSR] = PSR_MODE_USR;
  tcb_array[IDLE_TCB].priority = IDLE_TCB;
  tcb_array[IDLE_TCB].actual_priority = IDLE_TCB;
  tcb_array[IDLE_TCB].next_wakeup_time = 0;
  tcb_array[IDLE_TCB].state = RUNNABLE;
  /* Set svc stack pointer top to this thread's kstack */
  tcb_array[IDLE_TCB].ctx.special_regs[SVC_SP] = (
          (uint32_t)&tcb_array[IDLE_TCB].kstack[KSTACK_WORDS-1]);
  tcb_array[IDLE_TCB].alive = 1;
  //task starts with no mutexes, so linked list of mutexes is NULL
  tcb_array[IDLE_TCB].mutex_list_head = NULL;
    
  //add newly created task to runnable pool
  runnable_pool = 1 << IDLE_TCB;
  waiting_pool = 0;
  
  return 0;
}


int syscall_thread_create(thread_fn fn, uint32_t *stack_start, 
  unsigned int prio, unsigned int C, unsigned int T) {
    
  if ((fn == NULL) || (stack_start == NULL) || (prio>(NUM_TASKS-1)))
      return -1;
  tcb_array[prio].ctx.special_regs[IRQ_SPSR] = PSR_MODE_USR;
  tcb_array[prio].ctx.special_regs[USER_SP] = (uint32_t)stack_start;
  tcb_array[prio].pc = (uint32_t)fn;
  tcb_array[prio].c = C;
  tcb_array[prio].t = T;
  tcb_array[prio].c_used = 0;
  tcb_array[prio].priority = prio;
  tcb_array[prio].actual_priority = prio;
  /* Next_wakeup_time is the time at which the task became
   * runnable. All tasks start out as runnable, so next wakeup 
   * time starts at 0
   */
  tcb_array[prio].next_wakeup_time = 0;
  tcb_array[prio].state = RUNNABLE;
  tcb_array[prio].ctx.special_regs[SVC_SP] = 
      (uint32_t)&tcb_array[prio].kstack[KSTACK_WORDS-1];

  //task starts with no mutexes, so linked list of mutexes is NULL
  tcb_array[prio].mutex_list_head = NULL;
  // The alive field tells kernel that task was CREATED with this priority
  tcb_array[prio].alive = 1;
  //add newly created task to runnable pool
  runnable_pool |= 1 << prio;

  return 0;
}


/** @brief Initialize the mutex
 *
 *  A user program must call this initializer before attempting to lock or
 *  unlock the mutex. You can assume that this initializer will only 
 *  be called once by any test programs.
 *
 *  Implementation Details
 *  Each mutex has a next pointer that determines the chain of mutexes
 *  in the linked list. On initialization it gets initialized to NULL
 *
 *  @param mutex The mutex to act on.
 *  @param max_prio The maximum priority of a thread which could use
 *
 *  @return 0 on success or -1 on failure
 */
int syscall_mutex_init(mutex_t *mutex, unsigned int max_prio) {
  if ((mutex == NULL) || (max_prio > 31)) 
    return -1;
  mutex->ceiling_priority = max_prio;
  mutex->holding_thread_priority = -1;
  //currently only node in mutex linked list
  mutex->next = NULL;
  return 0;
}

/** @brief Lock the mutex
 *
 *  This function will not return (may block) until the current thread has
 *  exclusive rights to the mutex. You can assume the mutex has been
 *  initialized.
 *
 *  Implementation Details
 *  To support nested mutexes, each thread has a linked list of mutexes
 *  and an actual priority field that changes. When a thread acquires a 
 *  mutex, its actual priority changes and its mutex is adding to the 
 *  linked list of mutexes
 *
 *  @param mutex The mutex to act on.
 */
void syscall_mutex_lock(mutex_t *mutex) {
  /* Thread trying to acquire lock cannot be preempted. 
   * call to mutex_lock must block till the thread gets the mutex. 
   * So disable all interrupts till you get mutex
   */
  disable_interrupts();
  
  volatile tcb* task = &(tcb_array[priority_map[running_task_tcb_index]]);
  
  /* When a thread acquires a mutex its *actual_priority* changes
   * to the min of the two because in nested mutex cases, a thread
   * could have already acquired a higher priority mutex 
   */
  int new_priority = min(task->actual_priority,mutex->ceiling_priority);
  while (1) {
    // A thread is holding the mutex; will deadlock if you enter this case
    if (mutex->holding_thread_priority != -1)
      continue;
    //no thread is holding mutex
    else {
      //update mutex holding thread priority
      mutex->holding_thread_priority =  task->priority;
      
      //add mutex to the linked list of mutexes
      if (task->mutex_list_head == NULL) {
        task->mutex_list_head = mutex;
        mutex->next = NULL;
      }
      //first mutex thread is acquiring
      else {
        mutex->next = task->mutex_list_head;
        task->mutex_list_head = mutex;
      }
      break;
    }
  }

  /* Remove old priority thread from runnable pool and add new priority thread
   * NOTE: the priority field of the tcb struct DOES NOT CHANGE here.
   * Instead we have a priority map whose entry at the index
   * mutex->ceiling_priority changes to map to the thread's priority
   */
  runnable_pool &= ~(1<<task->actual_priority);
  runnable_pool |= (1<<new_priority);
 
  //set the *actual* priority of the thread since it acquried a mutex
  task->actual_priority = new_priority;

  /* Update the priority map so that the scheduler when it picks the
   * higher priority task to run, priority_map[runnable_task_tcb_index]
   * is actually this thread that acquried the mutex
   */
  priority_map[mutex->ceiling_priority] = task->priority;

  enable_interrupts();
}

/** @brief Unlock the mutex
 *
 * Implementation details
 *
 * To support nested mutexes, this operation will actually be O(n) in
 * the worst case. We go through the list of mutexes and remove the one
 * we were asked to unlock. But there are many cases to deal with in the
 * runnable pool, especially if a thread is holding another mutex of the
 * same priority
 *
 *  @param mutex The mutex to act on.
 */
void syscall_mutex_unlock(mutex_t *mutex) {
  /* We disable interrupts because want this operation to be atomic i.e
   * another thread SHOULD NOT interrupt this operation because it
   * would break if it got interrupted after changing the state of the 
   * mutex but before the runnable pool was updated
   */
  disable_interrupts();

  volatile tcb* task = &(tcb_array[priority_map[running_task_tcb_index]]);
  
  //alert that no thread is holding mutex
  mutex->holding_thread_priority = -1;
 
  //remove the mutex from thread's linked list
  if (task->mutex_list_head == NULL) {
    printk("Trying to remove from empty list of mutexes \n");
    syscall_exit(1);
  }

  //remove the mutex from the tasks's mutex linked list
  volatile mutex_t *current = task->mutex_list_head;
  volatile mutex_t *prev = NULL;
  int deleted = 0;
  /* Flag to denote if another thread is holding another mutex of same
   * priority as mutex we want to remove
   */
  int flag = 0;
  
  //mutex is first element to remove
  if (current == mutex) {
    task->mutex_list_head = current->next;
    deleted = 1;
  }
  // Go through linked list and delete mutex 
  else {
    volatile mutex_t *next = current->next;
    prev = task->mutex_list_head;
    current = prev->next;
    while (current) {
      next = current->next;
      if (current == mutex) {
        prev->next = next;
        deleted = 1;
        break;
      }
      prev = current;
      current = next;
    }
  }
 
  //error checking but should never get here
  if (deleted != 1) {
      printk("Did not delete node \n");
      syscall_exit(1);
  }
  
  //find new priority of the mutex;
  int new_priority = -1;
  volatile mutex_t *ptr = task->mutex_list_head;
  while (ptr) {
    if ((new_priority == -1) || (ptr->ceiling_priority < new_priority)) 
      new_priority = ptr->ceiling_priority;

    /* Thread is holding another mutex of same priority, 
     * so should not reset priority map
     */
    if (ptr->ceiling_priority == mutex->ceiling_priority) 
      flag = 1;
    ptr = ptr->next;
  }
  
  /* Thread is holding no mutex any more so return it back to the 
   * original priority that it started with
   */
  if (new_priority == -1) 
    new_priority = task->priority;
  
  /* Remove the task with mutex ceiling priority 
   * but only remove it if the current task is not holding 
   * another mutex of same priority
   */ 
  if (!flag) 
    runnable_pool &= ~(1<<mutex->ceiling_priority);

  /* Add the new priority thread back to runnable pool. If the thread
   * still holds a mutex of the same priority, then this line just
   * sets an already set bit
   */ 
  runnable_pool |= (1<<new_priority);

  /* Thread released mutex so priority map goes back to default value
   * but must take care to ensure that if current thread is 
   * already holding another mutex of same priority then can't 
   * reset priority maps just yet
   */
  if (!flag)
    priority_map[mutex->ceiling_priority] = mutex->ceiling_priority;
  
  /* But don't remove a task that was created with priority that 
   * was same as mutex ceiling priority
   */ 
  if (tcb_array[mutex->ceiling_priority].alive &&
    tcb_array[mutex->ceiling_priority].state == RUNNABLE)
    runnable_pool |= (1<<mutex->ceiling_priority);
  
  /* Newly running task's priority is either the priority of the 
   * higest priority mutex it is holding or it is task's original priority
   */
  running_task_tcb_index = new_priority;
  task->actual_priority = new_priority;

  enable_interrupts();
}

/** @brief Efficiently waits to run until the next period */
void syscall_wait_until_next_period(void) {
  //error checking but should never enter here
  if (priority_map[running_task_tcb_index] != running_task_tcb_index) {
    printk("Thread is holding mutex while trying to sleep \n");
    syscall_exit(1);
  }
  tcb_array[running_task_tcb_index].state = WAITING;
  while (tcb_array[running_task_tcb_index].state == WAITING);
}

unsigned int syscall_get_time(void) {
  return curr_time;
}

int syscall_scheduler_start(void) {
  /* Test schedulability */
  int i;
  float sum = 0;

  // Sum C/T of all runnable tasks 
  for (i = 0; i < NUM_TASKS-1; i++) {
    if (tcb_array[i].state == RUNNABLE)
      sum += ((float)tcb_array[i].c)/tcb_array[i].t;
  }
  
  // Perform UB test
  if (!(sum <= U[(__builtin_popcount(runnable_pool)-1)])) 
    return -1; // Not schedulable

  enable_interrupts();
  timer_start(1000); // Fire timer every 1 ms

  while (1);

  return 0;
}

/*************************************************************************/
/* TA system call implementations:                                       */
/*************************************************************************/

void *syscall_sbrk(int incr) {
  extern char __heap_low; // Defined by the linker
  extern char __heap_top; // Defined by the linker
  char *prev_heap_end;

  if (heap_end == 0) {
    // Initialize heap_end if this is the first time sbrk was called
    heap_end = &__heap_low;
  }

  prev_heap_end = heap_end;
  if (heap_end + incr > &__heap_top) {
    // Heap and stack collision, return error
    return (void *) -1;
  }

  // update heap_end and return old heap_end
  heap_end += incr;
  return (void *) prev_heap_end;
}

int syscall_close(int file) {
  return -1;
}

int syscall_fstat(int file, void *st) {
  return 0;
}

int syscall_isatty(int file) {
  return 1;
}

int syscall_lseek(int file, int ptr, int dir) {
  return 0;
}
