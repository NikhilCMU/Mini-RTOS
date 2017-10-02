/**
 * @file   main.c
 *
 * @brief  Test for nested mutex implementation
 */

#include <stdio.h>
#include <syscall_thread.h>
#include <mutex_type.h>

/** @brief 3x time required to print status information to reduce spin wait */
#define PRINT_STATUS_TIME_MS 6

/** @brief thread user space stack size - 4KB */
#define USR_STACK_WORDS 1024

uint32_t idle_stack[USR_STACK_WORDS];
uint32_t thread1_stack[USR_STACK_WORDS];
uint32_t thread2_stack[USR_STACK_WORDS];
uint32_t thread3_stack[USR_STACK_WORDS];

mutex_t mutex4,mutex3,mutex2;

/** @brief Spin waits for approximately ms milliseconds
 *
 *  @param ms   number of millis to loop for.
 */
void spin_wait(unsigned int ms) {
  int i, j;
  for (j = 0; j < ms; j++) {
    for (i = 0; i < 1150; i++) {
      // 1150 was determined to be approximately 1 ms
      __asm__("");
    }
  }
}

/** @brief Prints lock status information of a thread
 *
 *  @param name       name of the thread
 *  @param is_locked  whether the thread locked or released the mutex
 */
void print_status(const char *name, int is_locked, int mutex_number) {
  if (is_locked) {
    printf("t = %d --- Task: %s, mutex %d locked\n", get_time(), name,
            mutex_number);
  } else {
    printf("t = %d --- Task: %s, mutex %d unlocked\n", get_time(), name,
            mutex_number);
  }
}

/** @brief Default idle thread which just loops infinitely
 */
void idle_thread(void) {
  while(1);
}

/** @brief Basic thread which locks and unlocks a mutex
 */
void thread_8(void) {
  while(1) {
    mutex_lock(&mutex4);
    print_status("8", 1, 4);
    mutex_lock(&mutex3);
    print_status("8", 1, 3);
    mutex_lock(&mutex2);
    print_status("8", 1, 2);
    
    spin_wait(200-PRINT_STATUS_TIME_MS);
    
    print_status("8",0, 2);
    mutex_unlock(&mutex2);
    
    print_status("8", 0, 3);
    mutex_unlock(&mutex3);

    print_status("8", 0, 4);
    mutex_unlock(&mutex4);

    wait_until_next_period();
  }
}

/** @brief Basic thread which locks and unlocks a mutex
 */
void thread_2(void) {
  while(1) {
    mutex_lock(&mutex4);
    print_status("2", 1, 4);

    spin_wait(50-PRINT_STATUS_TIME_MS);
    
    print_status("2", 0, 4);
    mutex_unlock(&mutex4);

    wait_until_next_period();
  }
}

int main(void) {
  int status;
  status = thread_init(&idle_thread, &idle_stack[USR_STACK_WORDS-1]);
  if (status) {
    printf("Failed to initialize thread library: %d\n", status);
    return 1;
  }

  status = mutex_init(&mutex4, 2);
  if (status) {
    printf("Mutex initialization failed: %d\n", status);
    return 1;
  }
  
  status = mutex_init(&mutex3, 2);
  if (status) {
    printf("Mutex initialization failed: %d\n", status);
    return 1;
  }
  
  status = mutex_init(&mutex2, 2);
  if (status) {
    printf("Mutex initialization failed: %d\n", status);
    return 1;
  }

  status = thread_create(&thread_8, &thread1_stack[USR_STACK_WORDS-1], 8, 200, 1000);
  if (status) {
    printf("Failed to create thread 1: %d\n", status);
    return 1;
  }

  status = thread_create(&thread_2, &thread2_stack[USR_STACK_WORDS-1], 2, 50, 100);
  if (status) {
    printf("Failed to create thread 2: %d\n", status);
    return 1;
  }

  printf("Successfully created threads! Starting scheduler...\n");

  status = scheduler_start();
  if (status) {
    printf("Threads are unschedulable! %d\n", status);
    return 1;
  }
  
  // Should never get here.
  return 2;
}

