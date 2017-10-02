/**
 * @file   supervisor.S
 *
 * @brief  Assembly implementation to setup interrupts and 
 * enter/exit user mode
 *
 * @date   October 8, 2015
 * @author Nikhil Nilakantan <nnilakan@andrew.cmu.edu>
 */

.section ".text"

#include <psr.h>

/**
 * vector table that is loaded by install_vector_table to address 0x0
 */
interrupt_vector_table:
  // ARM core does the following on interrupt:
  // 1) save cpsr into spsr
  // 2) set mode bits in current cpsr
  // 3) disable further interrupts of lower/same priority
  // 4) store return address in lr
  // 5) set pc to correct vector table entry below
  ldr pc, _reset_asm_handler                 // priority: 1st
  ldr pc, _undefined_instruction_asm_handler // priority: 6th
  ldr pc, _swi_asm_handler                   // priority: 6th
  ldr pc, _prefetch_abort_asm_handler        // priority: 5th
  ldr pc, _data_abort_asm_handler            // priority: 2nd
  ldr pc, _reset_asm_handler                 // priority: undefined
  ldr pc, _irq_asm_handler                   // priority: 4th
  ldr pc, _fiq_asm_handler                   // priority: 3rd

/**
 * SOFT vector table that is loaded by install_vector_table ABOVE
 * interrupt_vector_table
 */
// to make sure the addresses are aligned this must follow the
// actual vector table above!
_reset_asm_handler:                 .word reset_asm_handler
_undefined_instruction_asm_handler: .word undefined_instruction_asm_handler
_swi_asm_handler:                   .word swi_asm_handler
_prefetch_abort_asm_handler:        .word prefetch_abort_asm_handler
_data_abort_asm_handler:            .word data_abort_asm_handler
_irq_asm_handler:                   .word irq_asm_handler
_fiq_asm_handler:                   .word fiq_asm_handler

/**
 * called to install the vector table at address 0x0
 */
.global install_interrupt_table
install_interrupt_table:
  /* Save context, ARM convention */
  push {r4-r9}
  ldr r0,= interrupt_vector_table
  ldr r1,= 0x0
  /* Install vector table */
  ldmia r0!, {r2-r9}
  stmia r1!, {r2-r9}
  /* Install SOFT vector table */
  ldmia r0!, {r2-r8}
  stmia r1!, {r2-r8}
  /* Restore context */
  pop {r4-r9}
  bx lr     //mov pc,lr

/************************************************************/
/* Assembly handlers for interrupts in the vector table     */
/************************************************************/

swi_asm_handler:
  cpsie i
  /* Make space to store SPSR */
  sub sp, sp, #4
  //5th argument for system calls is passed in r12
  stmfd sp!, {r0-r12, lr}
  mrs r2, spsr
  str r2, [sp, #14*4]
  /* Store stack pointer as second argument to swi_c_handler */
  mov r1, sp
  /* Get swi_num */
  ldr r0, [lr, #-4]
  bic r0, r0, #0xff000000
  bl swi_c_handler
  /* Restore SPSR */
  ldr r2, [sp, #14*4]
  msr spsr, r2
  /* Move stack pointer to point to r1 to preserve 
  swi_c_handler return value r0 */
  add sp, sp, #4
  ldmfd sp!, {r1-r12, lr}
  /* Restore space to store SPSR */
  add sp, sp, #4
  movs pc, lr

irq_asm_handler:
  /* Take into account pc offset */
  sub lr,lr,#4

  /* Use IRQ stack to save thread context */
  ldr sp,= __irq_stack_top

  /* Save IRQ mode context */
  stmfd sp!, {r0-r12, r14}
  mrs r2, spsr
  stmfd sp!, {r2} // Save spsr
  /* Save IRQ mode context */

  //Temporary reference to IRQ stack pointer
  mov r0, sp

  /* Save SVC mode context */
  msr cpsr_c, #(PSR_MODE_SVC | PSR_IRQ) // Switch to SVC mode
  mrs r2, spsr
  stmfd r0!, {r2, sp, lr}
  /* Save SVC mode context */

  /* Save USR/SYS mode context */
  msr cpsr_c, #(PSR_MODE_SYS | PSR_IRQ) // Switch to System mode
  stmfd r0!, {sp, lr}
  /* Save USR mode context*/

  msr cpsr_c, #(PSR_MODE_IRQ | PSR_IRQ) // Switch back to IRQ mode

  mov sp,r0
  
  bl irq_c_handler

  mov sp, r0
  
  /* Restore USR mode context */
  msr cpsr_c, #(PSR_MODE_SYS | PSR_IRQ) // Switch to System mode
  ldmfd r0!, {sp, lr}
  /* Restore USR mode context */

  /* Restore SVC mode context */
  msr cpsr_c, #(PSR_MODE_SVC | PSR_IRQ) // Switch to SVC mode
  ldmfd r0!, {r2, sp, lr}
  msr spsr, r2
  /* Restore SVC mode context */

  /* Restore IRQ mode context */
  msr cpsr_c, #(PSR_MODE_IRQ | PSR_IRQ)
  ldmfd r0!, {r2}
  //restore only spsr here because cpsr automatically restored
  msr spsr, r2
  mov sp,r0
  ldmfd sp!, {r0-r12, r14}
  /* Restore IRQ mode context */

  /* Restore PC */
  movs pc, lr

reset_asm_handler:
  bkpt

/************************************************************
 * If you fall into one of these handlers something bad is
 * happening. bkpt will drop back into gdb so you can debug.
 ************************************************************/
undefined_instruction_asm_handler:
  bkpt

prefetch_abort_asm_handler:
  bkpt

data_abort_asm_handler:
  bkpt

fiq_asm_handler:
  bkpt


/************************************************************/
/* Initializes cpsr for user mode and jumps to user program */
/************************************************************/
.global enter_user_mode
enter_user_mode:
  //save supervisor context r0-r12,lr and spsr
  SUB sp,sp,#4      //space spsr
  STMFD sp!, {r0-r12,lr}
  MRS r2,spsr
  STR r2,[sp,#14*4]     //store spsr above gp regs

  /* Changing processor mode to user mode, DISABLING interrupts */
  ldr r2,= 0x90
  msr cpsr_c, r2

  /* Setting the user mode sp to label __user_stack_top */
  ldr sp,= __user_stack_top

  /* Jumping and linking to user program */
  bl __user_program
