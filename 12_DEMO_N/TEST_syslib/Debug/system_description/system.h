/* system.h
 *
 * Machine generated for a CPU named "cpu" as defined in:
 * I:\AX\AX301\TEST\DEMO_N\kernel.ptf
 *
 * Generated: 2014-04-30 15:38:44.228
 *
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
 * system configuration
 *
 */

#define ALT_SYSTEM_NAME "kernel"
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_DEVICE_FAMILY "CYCLONEIVE"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN_BASE 0x00001908
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_PRESENT
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT_BASE 0x00001908
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_PRESENT
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDERR_BASE 0x00001908
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_PRESENT
#define ALT_CPU_FREQ 100000000
#define ALT_IRQ_BASE NULL
#define ALT_LEGACY_INTERRUPT_API_PRESENT

/*
 * processor configuration
 *
 */

#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_BIG_ENDIAN 0
#define NIOS2_INTERRUPT_CONTROLLER_ID 0

#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_FLUSHDA_SUPPORTED

#define NIOS2_EXCEPTION_ADDR 0x04000020
#define NIOS2_RESET_ADDR 0x00000000
#define NIOS2_BREAK_ADDR 0x00001020

#define NIOS2_HAS_DEBUG_STUB

#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0

/*
 * A define for each class of peripheral
 *
 */

#define __ALTERA_AVALON_SYSID
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_EPCS_FLASH_CONTROLLER
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_UART
#define __ALTERA_AVALON_TIMER

/*
 * sysid configuration
 *
 */

#define SYSID_NAME "/dev/sysid"
#define SYSID_TYPE "altera_avalon_sysid"
#define SYSID_BASE 0x00001900
#define SYSID_SPAN 8
#define SYSID_ID 0u
#define SYSID_TIMESTAMP 1395936883u
#define SYSID_REGENERATE_VALUES 0
#define ALT_MODULE_CLASS_sysid altera_avalon_sysid

/*
 * sdram configuration
 *
 */

#define SDRAM_NAME "/dev/sdram"
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_BASE 0x04000000
#define SDRAM_SPAN 33554432
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_ADDR_WIDTH 13
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SDRAM_COL_WIDTH 9
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_REFRESH_PERIOD 15.625
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_CAS_LATENCY 3
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_AC 5.5
#define SDRAM_T_WR 14.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_SHARED_DATA 0
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_IS_INITIALIZED 1
#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller

/*
 * epcs configuration
 *
 */

#define EPCS_NAME "/dev/epcs"
#define EPCS_TYPE "altera_avalon_epcs_flash_controller"
#define EPCS_BASE 0x00000000
#define EPCS_SPAN 2048
#define EPCS_IRQ 0
#define EPCS_IRQ_INTERRUPT_CONTROLLER_ID 0
#define EPCS_DATABITS 8
#define EPCS_TARGETCLOCK 20
#define EPCS_CLOCKUNITS "MHz"
#define EPCS_CLOCKMULT 1000000
#define EPCS_NUMSLAVES 1
#define EPCS_ISMASTER 1
#define EPCS_CLOCKPOLARITY 0
#define EPCS_CLOCKPHASE 0
#define EPCS_LSBFIRST 0
#define EPCS_EXTRADELAY 0
#define EPCS_TARGETSSDELAY 100
#define EPCS_DELAYUNITS "us"
#define EPCS_DELAYMULT "1e-006"
#define EPCS_PREFIX "epcs_"
#define EPCS_REGISTER_OFFSET 0x400
#define EPCS_IGNORE_LEGACY_CHECK 1
#define EPCS_USE_ASMI_ATOM 0
#define EPCS_CLOCKUNIT "kHz"
#define EPCS_DELAYUNIT "us"
#define EPCS_DISABLEAVALONFLOWCONTROL 0
#define EPCS_INSERT_SYNC 0
#define EPCS_SYNC_REG_DEPTH 2
#define ALT_MODULE_CLASS_epcs altera_avalon_epcs_flash_controller

/*
 * jtag_uart configuration
 *
 */

#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_BASE 0x00001908
#define JTAG_UART_SPAN 8
#define JTAG_UART_IRQ 1
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_READ_CHAR_STREAM ""
#define JTAG_UART_SHOWASCII 1
#define JTAG_UART_RELATIVEPATH 1
#define JTAG_UART_READ_LE 0
#define JTAG_UART_WRITE_LE 0
#define JTAG_UART_ALTERA_SHOW_UNRELEASED_JTAG_UART_FEATURES 1
#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart

/*
 * led configuration
 *
 */

#define LED_NAME "/dev/led"
#define LED_TYPE "altera_avalon_pio"
#define LED_BASE 0x00001840
#define LED_SPAN 16
#define LED_DO_TEST_BENCH_WIRING 0
#define LED_DRIVEN_SIM_VALUE 0
#define LED_HAS_TRI 0
#define LED_HAS_OUT 1
#define LED_HAS_IN 0
#define LED_CAPTURE 0
#define LED_DATA_WIDTH 4
#define LED_RESET_VALUE 0
#define LED_EDGE_TYPE "NONE"
#define LED_IRQ_TYPE "NONE"
#define LED_BIT_CLEARING_EDGE_REGISTER 0
#define LED_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LED_FREQ 100000000
#define ALT_MODULE_CLASS_led altera_avalon_pio

/*
 * KEY2 configuration
 *
 */

#define KEY2_NAME "/dev/KEY2"
#define KEY2_TYPE "altera_avalon_pio"
#define KEY2_BASE 0x00001850
#define KEY2_SPAN 16
#define KEY2_IRQ 3
#define KEY2_IRQ_INTERRUPT_CONTROLLER_ID 0
#define KEY2_DO_TEST_BENCH_WIRING 0
#define KEY2_DRIVEN_SIM_VALUE 0
#define KEY2_HAS_TRI 0
#define KEY2_HAS_OUT 0
#define KEY2_HAS_IN 1
#define KEY2_CAPTURE 1
#define KEY2_DATA_WIDTH 1
#define KEY2_RESET_VALUE 0
#define KEY2_EDGE_TYPE "RISING"
#define KEY2_IRQ_TYPE "EDGE"
#define KEY2_BIT_CLEARING_EDGE_REGISTER 0
#define KEY2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define KEY2_FREQ 100000000
#define ALT_MODULE_CLASS_KEY2 altera_avalon_pio

/*
 * KEY3 configuration
 *
 */

#define KEY3_NAME "/dev/KEY3"
#define KEY3_TYPE "altera_avalon_pio"
#define KEY3_BASE 0x00001860
#define KEY3_SPAN 16
#define KEY3_IRQ 4
#define KEY3_IRQ_INTERRUPT_CONTROLLER_ID 0
#define KEY3_DO_TEST_BENCH_WIRING 0
#define KEY3_DRIVEN_SIM_VALUE 0
#define KEY3_HAS_TRI 0
#define KEY3_HAS_OUT 0
#define KEY3_HAS_IN 1
#define KEY3_CAPTURE 1
#define KEY3_DATA_WIDTH 1
#define KEY3_RESET_VALUE 0
#define KEY3_EDGE_TYPE "RISING"
#define KEY3_IRQ_TYPE "EDGE"
#define KEY3_BIT_CLEARING_EDGE_REGISTER 0
#define KEY3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define KEY3_FREQ 100000000
#define ALT_MODULE_CLASS_KEY3 altera_avalon_pio

/*
 * KEY4 configuration
 *
 */

#define KEY4_NAME "/dev/KEY4"
#define KEY4_TYPE "altera_avalon_pio"
#define KEY4_BASE 0x00001870
#define KEY4_SPAN 16
#define KEY4_IRQ 5
#define KEY4_IRQ_INTERRUPT_CONTROLLER_ID 0
#define KEY4_DO_TEST_BENCH_WIRING 0
#define KEY4_DRIVEN_SIM_VALUE 0
#define KEY4_HAS_TRI 0
#define KEY4_HAS_OUT 0
#define KEY4_HAS_IN 1
#define KEY4_CAPTURE 1
#define KEY4_DATA_WIDTH 1
#define KEY4_RESET_VALUE 0
#define KEY4_EDGE_TYPE "RISING"
#define KEY4_IRQ_TYPE "EDGE"
#define KEY4_BIT_CLEARING_EDGE_REGISTER 0
#define KEY4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define KEY4_FREQ 100000000
#define ALT_MODULE_CLASS_KEY4 altera_avalon_pio

/*
 * uart configuration
 *
 */

#define UART_NAME "/dev/uart"
#define UART_TYPE "altera_avalon_uart"
#define UART_BASE 0x00001800
#define UART_SPAN 32
#define UART_IRQ 2
#define UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define UART_BAUD 9600
#define UART_DATA_BITS 8
#define UART_FIXED_BAUD 0
#define UART_PARITY 'N'
#define UART_STOP_BITS 1
#define UART_SYNC_REG_DEPTH 2
#define UART_USE_CTS_RTS 0
#define UART_USE_EOP_REGISTER 0
#define UART_SIM_TRUE_BAUD 0
#define UART_SIM_CHAR_STREAM ""
#define UART_RELATIVEPATH 1
#define UART_FREQ 100000000
#define ALT_MODULE_CLASS_uart altera_avalon_uart

/*
 * sda configuration
 *
 */

#define SDA_NAME "/dev/sda"
#define SDA_TYPE "altera_avalon_pio"
#define SDA_BASE 0x00001880
#define SDA_SPAN 16
#define SDA_DO_TEST_BENCH_WIRING 0
#define SDA_DRIVEN_SIM_VALUE 0
#define SDA_HAS_TRI 1
#define SDA_HAS_OUT 0
#define SDA_HAS_IN 0
#define SDA_CAPTURE 0
#define SDA_DATA_WIDTH 1
#define SDA_RESET_VALUE 0
#define SDA_EDGE_TYPE "NONE"
#define SDA_IRQ_TYPE "NONE"
#define SDA_BIT_CLEARING_EDGE_REGISTER 0
#define SDA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SDA_FREQ 100000000
#define ALT_MODULE_CLASS_sda altera_avalon_pio

/*
 * scl configuration
 *
 */

#define SCL_NAME "/dev/scl"
#define SCL_TYPE "altera_avalon_pio"
#define SCL_BASE 0x00001890
#define SCL_SPAN 16
#define SCL_DO_TEST_BENCH_WIRING 0
#define SCL_DRIVEN_SIM_VALUE 0
#define SCL_HAS_TRI 0
#define SCL_HAS_OUT 1
#define SCL_HAS_IN 0
#define SCL_CAPTURE 0
#define SCL_DATA_WIDTH 1
#define SCL_RESET_VALUE 0
#define SCL_EDGE_TYPE "NONE"
#define SCL_IRQ_TYPE "NONE"
#define SCL_BIT_CLEARING_EDGE_REGISTER 0
#define SCL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SCL_FREQ 100000000
#define ALT_MODULE_CLASS_scl altera_avalon_pio

/*
 * rtc_sclk configuration
 *
 */

#define RTC_SCLK_NAME "/dev/rtc_sclk"
#define RTC_SCLK_TYPE "altera_avalon_pio"
#define RTC_SCLK_BASE 0x000018a0
#define RTC_SCLK_SPAN 16
#define RTC_SCLK_DO_TEST_BENCH_WIRING 0
#define RTC_SCLK_DRIVEN_SIM_VALUE 0
#define RTC_SCLK_HAS_TRI 0
#define RTC_SCLK_HAS_OUT 1
#define RTC_SCLK_HAS_IN 0
#define RTC_SCLK_CAPTURE 0
#define RTC_SCLK_DATA_WIDTH 1
#define RTC_SCLK_RESET_VALUE 0
#define RTC_SCLK_EDGE_TYPE "NONE"
#define RTC_SCLK_IRQ_TYPE "NONE"
#define RTC_SCLK_BIT_CLEARING_EDGE_REGISTER 0
#define RTC_SCLK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RTC_SCLK_FREQ 100000000
#define ALT_MODULE_CLASS_rtc_sclk altera_avalon_pio

/*
 * rtc_rst_n configuration
 *
 */

#define RTC_RST_N_NAME "/dev/rtc_rst_n"
#define RTC_RST_N_TYPE "altera_avalon_pio"
#define RTC_RST_N_BASE 0x000018b0
#define RTC_RST_N_SPAN 16
#define RTC_RST_N_DO_TEST_BENCH_WIRING 0
#define RTC_RST_N_DRIVEN_SIM_VALUE 0
#define RTC_RST_N_HAS_TRI 0
#define RTC_RST_N_HAS_OUT 1
#define RTC_RST_N_HAS_IN 0
#define RTC_RST_N_CAPTURE 0
#define RTC_RST_N_DATA_WIDTH 1
#define RTC_RST_N_RESET_VALUE 0
#define RTC_RST_N_EDGE_TYPE "NONE"
#define RTC_RST_N_IRQ_TYPE "NONE"
#define RTC_RST_N_BIT_CLEARING_EDGE_REGISTER 0
#define RTC_RST_N_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RTC_RST_N_FREQ 100000000
#define ALT_MODULE_CLASS_rtc_rst_n altera_avalon_pio

/*
 * rtc_data configuration
 *
 */

#define RTC_DATA_NAME "/dev/rtc_data"
#define RTC_DATA_TYPE "altera_avalon_pio"
#define RTC_DATA_BASE 0x000018c0
#define RTC_DATA_SPAN 16
#define RTC_DATA_DO_TEST_BENCH_WIRING 0
#define RTC_DATA_DRIVEN_SIM_VALUE 0
#define RTC_DATA_HAS_TRI 1
#define RTC_DATA_HAS_OUT 0
#define RTC_DATA_HAS_IN 0
#define RTC_DATA_CAPTURE 0
#define RTC_DATA_DATA_WIDTH 1
#define RTC_DATA_RESET_VALUE 0
#define RTC_DATA_EDGE_TYPE "NONE"
#define RTC_DATA_IRQ_TYPE "NONE"
#define RTC_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define RTC_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RTC_DATA_FREQ 100000000
#define ALT_MODULE_CLASS_rtc_data altera_avalon_pio

/*
 * buzzer configuration
 *
 */

#define BUZZER_NAME "/dev/buzzer"
#define BUZZER_TYPE "altera_avalon_pio"
#define BUZZER_BASE 0x000018d0
#define BUZZER_SPAN 16
#define BUZZER_DO_TEST_BENCH_WIRING 0
#define BUZZER_DRIVEN_SIM_VALUE 0
#define BUZZER_HAS_TRI 0
#define BUZZER_HAS_OUT 1
#define BUZZER_HAS_IN 0
#define BUZZER_CAPTURE 0
#define BUZZER_DATA_WIDTH 1
#define BUZZER_RESET_VALUE 0
#define BUZZER_EDGE_TYPE "NONE"
#define BUZZER_IRQ_TYPE "NONE"
#define BUZZER_BIT_CLEARING_EDGE_REGISTER 0
#define BUZZER_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BUZZER_FREQ 100000000
#define ALT_MODULE_CLASS_buzzer altera_avalon_pio

/*
 * dig configuration
 *
 */

#define DIG_NAME "/dev/dig"
#define DIG_TYPE "altera_avalon_pio"
#define DIG_BASE 0x000018e0
#define DIG_SPAN 16
#define DIG_DO_TEST_BENCH_WIRING 0
#define DIG_DRIVEN_SIM_VALUE 0
#define DIG_HAS_TRI 0
#define DIG_HAS_OUT 1
#define DIG_HAS_IN 0
#define DIG_CAPTURE 0
#define DIG_DATA_WIDTH 8
#define DIG_RESET_VALUE 0
#define DIG_EDGE_TYPE "NONE"
#define DIG_IRQ_TYPE "NONE"
#define DIG_BIT_CLEARING_EDGE_REGISTER 0
#define DIG_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DIG_FREQ 100000000
#define ALT_MODULE_CLASS_dig altera_avalon_pio

/*
 * sel configuration
 *
 */

#define SEL_NAME "/dev/sel"
#define SEL_TYPE "altera_avalon_pio"
#define SEL_BASE 0x000018f0
#define SEL_SPAN 16
#define SEL_DO_TEST_BENCH_WIRING 0
#define SEL_DRIVEN_SIM_VALUE 0
#define SEL_HAS_TRI 0
#define SEL_HAS_OUT 1
#define SEL_HAS_IN 0
#define SEL_CAPTURE 0
#define SEL_DATA_WIDTH 6
#define SEL_RESET_VALUE 0
#define SEL_EDGE_TYPE "NONE"
#define SEL_IRQ_TYPE "NONE"
#define SEL_BIT_CLEARING_EDGE_REGISTER 0
#define SEL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define SEL_FREQ 100000000
#define ALT_MODULE_CLASS_sel altera_avalon_pio

/*
 * timer configuration
 *
 */

#define TIMER_NAME "/dev/timer"
#define TIMER_TYPE "altera_avalon_timer"
#define TIMER_BASE 0x00001820
#define TIMER_SPAN 32
#define TIMER_IRQ 9
#define TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_ALWAYS_RUN 0
#define TIMER_FIXED_PERIOD 0
#define TIMER_SNAPSHOT 1
#define TIMER_PERIOD 1
#define TIMER_PERIOD_UNITS "ms"
#define TIMER_RESET_OUTPUT 0
#define TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_LOAD_VALUE 99999
#define TIMER_COUNTER_SIZE 32
#define TIMER_MULT 0.0010
#define TIMER_TICKS_PER_SEC 1000
#define TIMER_FREQ 100000000
#define ALT_MODULE_CLASS_timer altera_avalon_timer

/*
 * system library configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER
#define ALT_TIMESTAMP_CLK none

/*
 * Devices associated with code sections.
 *
 */

#define ALT_TEXT_DEVICE       SDRAM
#define ALT_RODATA_DEVICE     SDRAM
#define ALT_RWDATA_DEVICE     SDRAM
#define ALT_EXCEPTIONS_DEVICE SDRAM
#define ALT_RESET_DEVICE      EPCS


#endif /* __SYSTEM_H_ */
