/**
 * @file   adc_driver.h
 *
 * @brief  SPI interface with MCP3002 ADC chip
 *
 * @date   August 28 2015
 * @author Aaron Reyes <areyes@andrew.cmu.edu>
 */

#ifndef _ADC_DRIVER_H_
#define _ADC_DRIVER_H_

#include <kstdint.h>

/**
 * @brief initialize SPI interface specifically for ADC
 */
void adc_init(void);

/**
 * @brief read a 10 bit value from the ADC using "channel"
 *
 * @param channel either 0 or 1
 * @return the 10 bit value read from the ADC
 */
uint16_t adc_read(uint8_t channel);

#endif /* _ADC_DRIVER_H_ */
