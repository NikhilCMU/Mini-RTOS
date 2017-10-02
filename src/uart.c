/**
 * @file   uart.c
 *
 * @brief  lower level hardware interactions for uart on pi
 *
 * @date   October 2, 2015
 * @author Nikhil Nilakantan <nnilakan@andrew.cmu.edu>
 */

#include <BCM2836.h>
#include <kstdint.h>
#include <gpio.h>

/** @brief UART Enable Register */
#define AUXENB_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0x215004)
/** @brief UART FIFO Register (Data) */
#define AUX_MU_IO_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0x215040)
/** @brief UART Interrupt Enable Register */
#define AUX_MU_IER_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0x215044)
/** @brief UART Interrupt Status Register */
#define AUX_MU_IIR_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0x215048)
/** @brief UART Line Data Format Register */
#define AUX_MU_LCR_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0x21504c)
/** @brief UART Data Status Register */
#define AUX_MU_LSR_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0x215054)
/** @brief UART Status Register */
#define AUX_MU_STAT_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0X215064)
/** @brief UART Baud Value Register (16-bit) */
#define AUX_MU_BAUD (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0x215068)

/** @brief System clock frequency - 250MHz */
#define SYSTEM_CLOCK_FREQ 250000000.0
/** @brief Baud value - 115200 */
#define BAUD_VALUE 115200.0
/** @brief Calculated baudrate */
#define BAUDRATE_REG (uint16_t) (SYSTEM_CLOCK_FREQ/(BAUD_VALUE * 8) - 1)

/** @brief GPIO UART RX pin */
#define RX_PIN 15
/** @brief GPIO UART TX pin */
#define TX_PIN 14

/** @brief Auxiliary enable for mini UART */
#define AUX_ENABLE 0x1
/** @brief Clear bits */
#define CLR 0
/** @brief Set mini UART to 8-bit mode in LCR register */
#define SET_8_BIT_MODE 0x3
/** @brief Clear FIFO in Interrupt Indentify Register (Set bits 1 and 2) */
#define CLEAR_FIFO 0x6


void uart_init(void) {
  // Enable mini UART
  *AUXENB_REG |= AUX_ENABLE;

  // Set baud rate
  *AUX_MU_BAUD = (uint32_t)BAUDRATE_REG;

  // Disable interrups
  *AUX_MU_IER_REG = CLR;

  // Set 8-bit mode
  *AUX_MU_LCR_REG |= SET_8_BIT_MODE;

  // Clear FIFOs
  *AUX_MU_IIR_REG = CLEAR_FIFO;

  // set GPIO pins to correct function on pg 102 of BCM2835 peripherals
  gpio_config(RX_PIN, GPIO_FUN_ALT5);
  gpio_config(TX_PIN, GPIO_FUN_ALT5);

  // Configure GPIO pullups
  gpio_set_pull(RX_PIN, GPIO_PULL_DISABLE);
  gpio_set_pull(TX_PIN, GPIO_PULL_DISABLE);

}

void uart_close(void) {
  // Disable mini UART
  *AUXENB_REG = CLR;
}


void uart_put_byte(uint8_t byte) {
  // Wait until there is space to transmit byte
  while (!(*AUX_MU_STAT_REG & 0x2));
  *AUX_MU_IO_REG = byte;
}


uint8_t uart_get_byte(void) {
  // Wait until there is at least 1 byte to pull from FIFO
  while (!(*AUX_MU_LSR_REG & 0x1));
  return *AUX_MU_IO_REG & 0xff;
}
