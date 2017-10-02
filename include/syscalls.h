/**
 * @file   syscalls.h
 *
 * @brief  Syscall handlers, used by kernel's SWI handler.
 *
 * @date   September 26, 2015
 * @author Kenneth Li <kyli@andrew.cmu.edu>
 */

#ifndef _SYSCALLS_H_
#define _SYSCALLS_H_

#include <kstdint.h>
#include <mutex_type.h>


/** @brief thread user space stack size - 4KB */
#define KSTACK_WORDS 1024
/** @brief Number of threads that the processer can run */
#define NUM_TASKS 32
/** @brief User mode stack pointer */
#define USER_SP 0
/** @brief User mode link register */
#define USER_LR 1
/** @brief Supervisor mode SPSR */
#define SVC_SPSR 2
/** @brief Supervisor mode stack pointer */
#define SVC_SP 3
/** @brief Supervisor mode link register */
#define SVC_LR 4
/** @brief IRQ mode SPSR */
#define IRQ_SPSR 5

/** @brief Number of common registers saved across all modes */
#define NUM_COMMON_REGS 13
/** @brief Special (banked) registers across modes */
#define NUM_SPECIAL_REGS 6

/** @brief Signature of a thread function
 *
 *  Each thread should run a function that never exits. Instead, you can assume
 *  that any test functions will spin wait (if we want to overrun the execution
 *  time) or use wait_until_next_period().
 */
typedef void (*thread_fn) (void);

/** @brief The state of which a thread can be in
 *  
 *  Each thread can either be WAITING, RUNNING, or RUNNABLE.
 */
typedef enum {WAITING, RUNNING, RUNNABLE} task_state;

/** @brief The context of a thread. 
 *   These registers have to be the same when the thread starts running again
 */
typedef struct context{
  /** @brief common registers r0-r12 across all modes */
  uint32_t common_regs[NUM_COMMON_REGS];
  /** @brief special registers spsr,lr,sp for modes */
  uint32_t special_regs[NUM_SPECIAL_REGS];
} context;


/** @brief Task Control Block structure for threads
 *
 *  Each thread has its own set of information that must be saved and
 *  restored to ensure we can leave and return to the thread function.
 */
typedef struct task_control_block {
  /** @brief program counter of thread */
  unsigned int pc;
  /** @brief context of thread (registers) */
  context ctx;
  /** @brief C time of thread for scheduling */
  unsigned int c;
  /** @brief T time of thread for scheduling */
  unsigned int t;
  /** @brief c_used amount of time task has run */
  unsigned int c_used;
  /** @brief priority of thread */
  volatile int priority;
  /** @brief actual priority of thread that changes as it acquires mutexes */
  volatile int actual_priority;
  /** @brief next wake up time for scheduling */
  unsigned int next_wakeup_time;
  /** @brief current state of thread must be volatile 
   * because a different file changes it */
  volatile task_state state;
  /** @brief kernel stack for each thread */
  uint32_t kstack[KSTACK_WORDS];
  /** @brief variable to denote if a thread was created vs a thread that was 
   * elevated to a priority 
   */
  volatile int alive;
  /** @brief thread mutex linked list head*/
  volatile mutex_t *mutex_list_head;
} tcb;

/**
 * @brief See linux man page for sbrk
 *
 * @param incr  amount to increment data segment size by.
 * @return -1 if error, or the previous end address of the heap
 */
void *syscall_sbrk(int incr);

/**
 * @brief See linux man page for write
 *
 * @param file  file descriptor to write to. In our kernel, we only support STDOUT.
 * @param ptr   pointer to buffer to write to
 * @param len   max length to write
 * @return -1 on error, otherwise the number of bytes written
 */
int syscall_write(int file, char *ptr, int len);

/**
 * @brief See linux man page for close.
 * Since we only read/write to stdin/stdout, close doesn't really do anything.
 *
 * @param file  file descriptor to close.
 * @return -1 on error, 0 on success.
 */
int syscall_close(int file);

/**
 * @brief See linux man page for fstat.
 * Since we don't have a file system, this doesn't actually do anything.
 *
 * @param file file descriptor to examine
 * @param st   pointer to stat structure
 * @return -1 on error, 0 on success
 */
int syscall_fstat(int file, void *st);

/**
 * @brief See linux man page for isatty.
 * Our implementation always returns TRUE since we only use stdin and stdout
 *
 * @param file  file descriptor to check.
 * @return boolean (1 or 0) indicating whether the fd is a tty
 */
int syscall_isatty(int file);

/**
 * @brief See linux man page for lseek.
 * Not implemented in our kernel since we don't have a filesystem.
 *
 * @param file  file descriptor
 * @param offset  offset
 * @param whence  see man page for appropriate values
 * @return -1 on error, 0 on success
 */
int syscall_lseek(int file, int offset, int whence);

/**
 * @brief See linux man page for read.
 *
 * @param file  file descriptor to read from. In our kernel, we only support STDIN.
 * @param ptr   pointer to buffer to read from
 * @param len   max length to read
 * @return -1 on error, otherwise number of bytes read
 */
int syscall_read(int file, char *ptr, int len);

/**
 * @brief Print out the exit status of the user program and hang with interrupts
 * @param status Exit status to return to the kernel
 */
void syscall_exit(int status);

/**
 * @brief Starts sampling the ADC periodically, calling the given callback
 *        with the ADC sample value.
 *
 * @param freq      frequency at which to sample
 * @param channel   channel to sample
 * @param callback  function to be called everytime a sample is read from the adc.
 *
 * @return 0 on success or -1 on failure
 */
int syscall_sample_adc_start(int freq, uint8_t channel, void (*callback)(uint16_t));

/**
 * @brief Stops periodic sampling of the ADC.
 *
 * @return 0 on success or -1 on failure
 */
int syscall_sample_adc_stop();


/** @brief Initialize the thread library
 *
 *  A user program must call this initializer before attempting to create any
 *  threads or start the scheduler.
 *
 *  @param idle_fn Pointer to a thread function to run when no other threads are
 *  runnable.
 *  @param idle_stack_start Pointer to the first valid location of idle thread's
 *  stack.
 *
 *  @return 0 on success or -1 on failure
 */
int syscall_thread_init(thread_fn idle_fn, uint32_t *idle_stack_start);

/** @brief Create a new thread running the given function
 *
 *  @param fn Pointer to the function to run in the new thread.
 *  @param stack_start Pointer to the first valid location of this thread's
 *  stack.
 *  @param prio Priority of this thread. Lower number are higher priority.
 *  @param C Real time execution time (ms).
 *  @param T Real time task period (ms).
 *
 *  @return 0 on success or -1 on failure
 */
int syscall_thread_create(thread_fn fn, uint32_t *stack_start,
                  unsigned int prio, unsigned int C, unsigned int T);

/** @brief Initialize the mutex
 *
 *  A user program must call this initializer before attempting to lock or
 *  unlock the mutex. You can assume that this initializer will only be called
 *  once by any test programs.
 *
 *  @param mutex The mutex to act on.
 *  @param max_prio The maximum priority of a thread which could use
 *
 *  @return 0 on success or -1 on failure
 */
int syscall_mutex_init(mutex_t *mutex, unsigned int max_prio);

/** @brief Lock the mutex
 *
 *  This function will not return (may block) until the current thread has
 *  exclusive rights to the mutex. You can assume the mutex has been
 *  initialized.
 *
 *  @param mutex The mutex to act on.
 */
void syscall_mutex_lock(mutex_t *mutex);

/** @brief Unlock the mutex
 *
 *  @param mutex The mutex to act on.
 */
void syscall_mutex_unlock(mutex_t *mutex);

/** @brief Efficiently waits to run until the next period */
void syscall_wait_until_next_period(void);

/** @brief Get the current time in milliseconds */
unsigned int syscall_get_time(void);

/** @brief Allow the kernel to start running the added task set.
 *
 *  This function should enable IRQs and thus enable your scheduler. The kernel
 *  will test that a task set with this new task is scheduleable before running
 *  and may return an error if this is not the case.
 *
 *  @return 0 on success or -1 on failure
 */
int syscall_scheduler_start(void);

#endif /* _SYSCALLS_H_ */
