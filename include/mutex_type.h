/** @file   mutex_type.h
 *
 *  @brief  Mutex type definition for 18-349.
 *
 *  @author Nikhil Nilakantan <nnilakan@andrew.cmu.edu>
 *  @author Karthic Palaniappan <kapalani@andrew.cmu.edu>
 */

#ifndef _KERNEL_MUTEX_T_H_
#define _KERNEL_MUTEX_T_H_

/** @brief the mutex structure */
typedef struct mutex {
  /** @brief highest priority thread that can hold this mutex */
  volatile int ceiling_priority;
  /** @brief index into tcb array of thread holding this mutex. 
   *  Used to check if some other thread is holding this mutex 
   */
  volatile int holding_thread_priority;
  /** @brief next pointer that holds next mutex in linked list */
  volatile struct mutex *next;
} mutex_t;


#endif /* _349LIBK_MUTEX_T_H_ */
