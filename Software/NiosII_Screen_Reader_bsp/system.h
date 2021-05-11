/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'NiosII' in SOPC Builder design 'Nios_Screen_Reader'
 * SOPC Builder design path: ../../Nios_Screen_Reader.sopcinfo
 *
 * Generated: Sat Aug 15 00:19:38 EEST 2020
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * Address configuration
 *
 */

#define ADDRESS_BASE 0x10001030
#define ADDRESS_BIT_CLEARING_EDGE_REGISTER 0
#define ADDRESS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define ADDRESS_CAPTURE 0
#define ADDRESS_DATA_WIDTH 20
#define ADDRESS_DO_TEST_BENCH_WIRING 0
#define ADDRESS_DRIVEN_SIM_VALUE 0
#define ADDRESS_EDGE_TYPE "NONE"
#define ADDRESS_FREQ 100000000
#define ADDRESS_HAS_IN 0
#define ADDRESS_HAS_OUT 1
#define ADDRESS_HAS_TRI 0
#define ADDRESS_IRQ -1
#define ADDRESS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ADDRESS_IRQ_TYPE "NONE"
#define ADDRESS_NAME "/dev/Address"
#define ADDRESS_RESET_VALUE 0
#define ADDRESS_SPAN 16
#define ADDRESS_TYPE "altera_avalon_pio"
#define ALT_MODULE_CLASS_Address altera_avalon_pio


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x10000820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 100000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1d
#define ALT_CPU_DCACHE_BYPASS_MASK 0x80000000
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x08000020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 100000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_EXTRA_EXCEPTION_INFO
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x1d
#define ALT_CPU_NAME "NiosII"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x08000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x10000820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 100000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1d
#define NIOS2_DCACHE_BYPASS_MASK 0x80000000
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x08000020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_EXTRA_EXCEPTION_INFO
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x1d
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x08000000


/*
 * DATA configuration
 *
 */

#define ALT_MODULE_CLASS_DATA altera_avalon_pio
#define DATA_BASE 0x10001040
#define DATA_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_CAPTURE 0
#define DATA_DATA_WIDTH 16
#define DATA_DO_TEST_BENCH_WIRING 0
#define DATA_DRIVEN_SIM_VALUE 0
#define DATA_EDGE_TYPE "NONE"
#define DATA_FREQ 100000000
#define DATA_HAS_IN 1
#define DATA_HAS_OUT 0
#define DATA_HAS_TRI 0
#define DATA_IRQ -1
#define DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DATA_IRQ_TYPE "NONE"
#define DATA_NAME "/dev/DATA"
#define DATA_RESET_VALUE 0
#define DATA_SPAN 16
#define DATA_TYPE "altera_avalon_pio"


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2
#define __ALTPLL


/*
 * Event_Register configuration
 *
 */

#define ALT_MODULE_CLASS_Event_Register altera_avalon_pio
#define EVENT_REGISTER_BASE 0x10001020
#define EVENT_REGISTER_BIT_CLEARING_EDGE_REGISTER 0
#define EVENT_REGISTER_BIT_MODIFYING_OUTPUT_REGISTER 0
#define EVENT_REGISTER_CAPTURE 0
#define EVENT_REGISTER_DATA_WIDTH 3
#define EVENT_REGISTER_DO_TEST_BENCH_WIRING 0
#define EVENT_REGISTER_DRIVEN_SIM_VALUE 0
#define EVENT_REGISTER_EDGE_TYPE "NONE"
#define EVENT_REGISTER_FREQ 100000000
#define EVENT_REGISTER_HAS_IN 1
#define EVENT_REGISTER_HAS_OUT 0
#define EVENT_REGISTER_HAS_TRI 0
#define EVENT_REGISTER_IRQ -1
#define EVENT_REGISTER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define EVENT_REGISTER_IRQ_TYPE "NONE"
#define EVENT_REGISTER_NAME "/dev/Event_Register"
#define EVENT_REGISTER_RESET_VALUE 0
#define EVENT_REGISTER_SPAN 16
#define EVENT_REGISTER_TYPE "altera_avalon_pio"


/*
 * JTAG configuration
 *
 */

#define ALT_MODULE_CLASS_JTAG altera_avalon_jtag_uart
#define JTAG_BASE 0x10001068
#define JTAG_IRQ 0
#define JTAG_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_NAME "/dev/JTAG"
#define JTAG_READ_DEPTH 64
#define JTAG_READ_THRESHOLD 8
#define JTAG_SPAN 8
#define JTAG_TYPE "altera_avalon_jtag_uart"
#define JTAG_WRITE_DEPTH 64
#define JTAG_WRITE_THRESHOLD 8


/*
 * Loading_Percentage configuration
 *
 */

#define ALT_MODULE_CLASS_Loading_Percentage altera_avalon_pio
#define LOADING_PERCENTAGE_BASE 0x10001000
#define LOADING_PERCENTAGE_BIT_CLEARING_EDGE_REGISTER 0
#define LOADING_PERCENTAGE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LOADING_PERCENTAGE_CAPTURE 0
#define LOADING_PERCENTAGE_DATA_WIDTH 7
#define LOADING_PERCENTAGE_DO_TEST_BENCH_WIRING 0
#define LOADING_PERCENTAGE_DRIVEN_SIM_VALUE 0
#define LOADING_PERCENTAGE_EDGE_TYPE "NONE"
#define LOADING_PERCENTAGE_FREQ 100000000
#define LOADING_PERCENTAGE_HAS_IN 0
#define LOADING_PERCENTAGE_HAS_OUT 1
#define LOADING_PERCENTAGE_HAS_TRI 0
#define LOADING_PERCENTAGE_IRQ -1
#define LOADING_PERCENTAGE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LOADING_PERCENTAGE_IRQ_TYPE "NONE"
#define LOADING_PERCENTAGE_NAME "/dev/Loading_Percentage"
#define LOADING_PERCENTAGE_RESET_VALUE 0
#define LOADING_PERCENTAGE_SPAN 16
#define LOADING_PERCENTAGE_TYPE "altera_avalon_pio"


/*
 * PLL configuration
 *
 */

#define ALT_MODULE_CLASS_PLL altpll
#define PLL_BASE 0x10001050
#define PLL_IRQ -1
#define PLL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PLL_NAME "/dev/PLL"
#define PLL_SPAN 16
#define PLL_TYPE "altpll"


/*
 * Response_Register configuration
 *
 */

#define ALT_MODULE_CLASS_Response_Register altera_avalon_pio
#define RESPONSE_REGISTER_BASE 0x10001010
#define RESPONSE_REGISTER_BIT_CLEARING_EDGE_REGISTER 0
#define RESPONSE_REGISTER_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RESPONSE_REGISTER_CAPTURE 0
#define RESPONSE_REGISTER_DATA_WIDTH 3
#define RESPONSE_REGISTER_DO_TEST_BENCH_WIRING 0
#define RESPONSE_REGISTER_DRIVEN_SIM_VALUE 0
#define RESPONSE_REGISTER_EDGE_TYPE "NONE"
#define RESPONSE_REGISTER_FREQ 100000000
#define RESPONSE_REGISTER_HAS_IN 0
#define RESPONSE_REGISTER_HAS_OUT 1
#define RESPONSE_REGISTER_HAS_TRI 0
#define RESPONSE_REGISTER_IRQ -1
#define RESPONSE_REGISTER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RESPONSE_REGISTER_IRQ_TYPE "NONE"
#define RESPONSE_REGISTER_NAME "/dev/Response_Register"
#define RESPONSE_REGISTER_RESET_VALUE 0
#define RESPONSE_REGISTER_SPAN 16
#define RESPONSE_REGISTER_TYPE "altera_avalon_pio"


/*
 * SDRAM configuration
 *
 */

#define ALT_MODULE_CLASS_SDRAM altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x8000000
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/SDRAM"
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_REFRESH_PERIOD 7.8125
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 10
#define SDRAM_SDRAM_DATA_WIDTH 32
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 134217728
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_WR 14.0


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/JTAG"
#define ALT_STDERR_BASE 0x10001068
#define ALT_STDERR_DEV JTAG
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/JTAG"
#define ALT_STDIN_BASE 0x10001068
#define ALT_STDIN_DEV JTAG
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/JTAG"
#define ALT_STDOUT_BASE 0x10001068
#define ALT_STDOUT_DEV JTAG
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "Nios_Screen_Reader"


/*
 * SystemID configuration
 *
 */

#define ALT_MODULE_CLASS_SystemID altera_avalon_sysid_qsys
#define SYSTEMID_BASE 0x10001060
#define SYSTEMID_ID 0
#define SYSTEMID_IRQ -1
#define SYSTEMID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSTEMID_NAME "/dev/SystemID"
#define SYSTEMID_SPAN 8
#define SYSTEMID_TIMESTAMP 1597418486
#define SYSTEMID_TYPE "altera_avalon_sysid_qsys"


/*
 * altera_hostfs configuration
 *
 */

#define ALTERA_HOSTFS_NAME "/mnt/host"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none

#endif /* __SYSTEM_H_ */
