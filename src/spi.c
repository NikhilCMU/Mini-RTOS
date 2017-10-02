/**
 * @file   spi.c
 *
 * @brief  SPI implementation on rpi 2
 *
 * @date   October 5, 2015
 * @author Nikhil Nilakantan <nnilakan@andrew.cmu.edu>
 */

#include <kstdint.h>
#include <gpio.h>
#include <spi.h>
#include <BCM2836.h>
#include <printk.h>

/** @brief SPI Master Control and Status Register */
#define CS_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0X204000)
/** @brief SPI Master TX and RX FIFOs */
#define FIFO_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0x204004)
/** @brief SPI Master Clock Divider */
#define CLK_REG (volatile uint32_t *)(MMIO_BASE_PHYSICAL + 0X204008)

/** @brief Clear bits */
#define CLR 0
/** @brief Clear the TX and RX FIFOS in CS_REG */
#define CLEAR_FIFO 0x3 << 4
/** @brief CPOL, CPHA bit location in CS_REG (Bits 2 and 3) */
#define CLOCK_ATTR_SHIFT 2
/** @brief CSPOL Bit 6 in CS_REG */
#define CHIP_SEL_POL_SHIFT 6
/** @brief TA Bit 7 in CS_REG */
#define SET_TA 0x80
/** @brief TXD Bit 18 in CS_REG */
#define TXD_MASK 1 << 18
/** @brief DONE Bit 16 in CS_REG */
#define DONE_MASK 1 << 16

void spi_master_init(uint32_t mode, uint32_t clk) {
  gpio_config(CE1_N, GPIO_FUN_ALT0);
  gpio_config(CE0_N, GPIO_FUN_ALT0);
  gpio_config(MISO, GPIO_FUN_ALT0);
  gpio_config(MOSI, GPIO_FUN_ALT0);
  gpio_config(SCLK, GPIO_FUN_ALT0);

  // Initially zero out the CS register
  *CS_REG = CLR;

  // Clear FIFOs
  *CS_REG = CLEAR_FIFO;

  // Set CPOL, CPHA
  *CS_REG |= (mode << CLOCK_ATTR_SHIFT);

  // Set clk
  *CLK_REG = clk;
}


void spi_master_chip_sel(uint32_t cs, uint32_t polarity) {
  *CS_REG |= (polarity << CHIP_SEL_POL_SHIFT);
  *CS_REG |= cs;
}


void spi_master_transfer_start(void) {
  // Set TA high
  *CS_REG |= SET_TA;
}


void spi_master_transfer_end(void) {
  // Set TA low
  *CS_REG &= ~SET_TA;
}

uint8_t spi_master_transfer(uint8_t data) {
  // Poll TXD until we can write data
  while (!(*CS_REG & TXD_MASK));
  *FIFO_REG |= data;

  // Poll DONE until we can read data
  while (!(*CS_REG & DONE_MASK));
  return *FIFO_REG;
}
