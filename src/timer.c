/**
 * @file   timer.c
 *
 * @brief  Implementation of routines for interacting with ARM timer
 *
 * @date   October 12, 2015
 * @author Nikhil Nilakantan <nnilakan@andrew.cmu.edu>
 */

#include <timer.h>
#include <kstdint.h>
#include <BCM2836.h>

/** @brief IRQ Pending Base Register */
#define IRQ_BASIC_PENDING_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0xB200)
 /** @brief Enable Basic IRQ Register */
#define ENABLE_BASIC_IRQ_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0xB218)
 /** @brief Disable Basic IRQ Register */
#define DISABLE_BASIC_IRQ_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0xB224)

/** @brief Timer Load Register */
#define TIMER_LOAD_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0xB400)
 /** @brief Timer Control Register */
#define TIMER_CONTROL_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0xB408)
 /** @brief Timer IRQ Clear/ Ack Register */
#define TIMER_IRQCLR_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0xB40C)
 /** @brief Timer RAW IRQ Register */
#define TIMER_RAWIRQ_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0xB410)

/** @brief 1 MHz*/
#define SYS_CLK 1000000
 /** @brief Write a value to Timer Clear register to clear pending IRQ */
#define CLEAR_PENDING_IRQ 1
 /** @brief Check if IRQ is pending (bit 0 of Timer Raw Irq reg) */
#define IRQ_PENDING 1
 /** @brief Enable basic IRQ */
#define ENABLE_TIMER_IRQ 1
 /** @brief Disable basic IRQ*/
#define DISABLE_TIMER_IRQ 1
 /** @brief Enable timer in Timer Control reg (bit 7) */
#define ENABLE_TIMER 1 << 7
 /** @brief Enable timer interrupts in Timer Control reg (bit 5) */
#define ENABLE_TIMER_INTERRUPT 1 << 5
 /** @brief Set timer to 32 bit mode in Timer Control reg (bit 1) */
#define SET_32BIT_MODE 1 << 1
 /** @brief Set prescale bits to 00 in Timer Control reg (bits 3 and 2)*/
#define SET_PRESCALE_BITS ~(0x3 << 2)

void timer_start(int freq) {
  // Enable ARM timer IRQ
  *ENABLE_BASIC_IRQ_REG = ENABLE_TIMER_IRQ;
 
  // Set prescale bits to 1
  *TIMER_CONTROL_REG &= SET_PRESCALE_BITS;

  // Enable timer and timer interrupt, and set 32-bit
  *TIMER_CONTROL_REG |= (ENABLE_TIMER | ENABLE_TIMER_INTERRUPT | SET_32BIT_MODE);

  // Set timer countdown (e.g. 1 second)
  *TIMER_LOAD_REG = SYS_CLK/freq;
}

void timer_stop(void) {
  // Disables timer IRQ's
  *DISABLE_BASIC_IRQ_REG = DISABLE_TIMER_IRQ;

  // Disable timer
  *TIMER_CONTROL_REG &= ~ENABLE_TIMER;
}


int timer_is_pending(void) {
  return *TIMER_RAWIRQ_REG & IRQ_PENDING;
}


void timer_clear_pending(void) {
  *TIMER_IRQCLR_REG = CLEAR_PENDING_IRQ;
}
