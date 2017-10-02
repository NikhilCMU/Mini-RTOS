/**
 * @file   adc_driver.c
 *
 * @brief  SPI driver for ADC
 *
 * @date   October 4, 2015
 * @author Nikhil Nilakantan <nnilakan@andrew.cmu.edu>
 */

#include <kstdint.h>
#include <gpio.h>
#include <adc_driver.h>
#include <printk.h>
#include <spi.h>

/** @brief Don't care all 0 bits */
#define DONTCARE 0
/** @brief 8-bit value filled as detailed in MCP3002, for channel 0 */
#define TRANSMIT_BYTE_0 0x68
/** @brief 8-bit value filled as detailed in MCP3002, for channel 1 */
#define TRANSMIT_BYTE_1 0x78

void adc_init(void) {
  spi_master_init(SPI_MODE0, SPI_CLK_DIV_512);
  spi_master_chip_sel(SPI_CS_0, SPI_CS_ACTIVE_LOW);
}

uint16_t adc_read(uint8_t channel) {
  uint8_t config_bits = 0;
  uint16_t adc_return;

  if (channel == 0) config_bits = TRANSMIT_BYTE_0;
  else if (channel == 1) config_bits = TRANSMIT_BYTE_1;

  spi_master_transfer_start();

  // Build 16-bit adc_return value
  adc_return = spi_master_transfer(config_bits) << 8;
  adc_return |= spi_master_transfer(DONTCARE);

  // End SPI transmission
  spi_master_transfer_end();

  return adc_return;
}
