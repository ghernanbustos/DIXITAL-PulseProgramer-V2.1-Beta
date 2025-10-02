/*
 * 	File: ad9854.h
 *
 *  Description: Header file with registers and macros for DDS ad9854
 *
 *  Project:     DIXITAL - Pulse programmer for NMR applications.
 *  Developer:   Guillermo Hernan Bustos
 *  Company:     Instituto de Fisica Enrique Gaviola - FAMAF U.N.C
 *  Email:       ghernanbustos@gmail.com
 *
 *   Copyright (C) 2024  Guillermo H. Bustos.
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
*/


#ifndef AD9854_H
#define AD9854_H

#include <stdint.h> // Typedef uint16_t
#include <math.h>
// Macro Variable for Debugging
#define DEBUG   
#define NUM_BYTES 4

#define FPGA_CLK_50 50000000 // FPGA 50Mhz
#define NCO_CLK_3 3000000 // FPGA nco clock 3Mhz
#define COUNTER_MODULE 4294967295 // (2^32-1)32bit fpga chrono module
#define NCO_MODULE 4294967296 // (2^32-1)32bit fpga chrono module
#define PGR_RAM_DEEP 64
#define NCO_PLUS_CHRONO_ON (1U << 7)

#define INIT_SIZE 8 // 8 bytes - 4 to control reg - 4 osk reg amplitude.
/*
const unsigned long  Freq_mult_ulong  = 938250;
const double Freq_mult_doulle = 938249.9223688533;
*/
// BITMASK CONSTANTS
// Refclock Multiplier FTW is dependent of this value 
// For a 20Mhz crystal oscillator on the Kit (up to x15 defined only)
#define      REFCLK_MULT_4     4 // InternalFreq = 80Mhz
#define      REFCLK_MULT_5     5 // InternalFreq = 100Mhz
#define      REFCLK_MULT_6     6 // InternalFreq = 120Mhz
#define      REFCLK_MULT_7     7 // InternalFreq = 140Mhz
#define      REFCLK_MULT_8     8 // InternalFreq = 160Mhz
#define      REFCLK_MULT_9     9 // InternalFreq = 180Mhz
#define      REFCLK_MULT_10   10 // InternalFreq = 200Mhz
#define      REFCLK_MULT_11   11 // InternalFreq = 220Mhz
#define      REFCLK_MULT_12   12 // InternalFreq = 240Mhz
#define      REFCLK_MULT_13   13 // InternalFreq = 260Mhz
#define      REFCLK_MULT_14   14 // InternalFreq = 280Mhz
#define      REFCLK_MULT_15   15 // InternalFreq = 300Mhz - Desired Freq

#define XTAL_OSC 20000000 // crystal oscillator board 
//#define MODULE (pow(2, 48)) 
#define SYSCLOCK (REFCLK_MULT_15 * XTAL_OSC) // Check if data is correct because of 64bit within 32bits arch
#define MODULE 938250 // rounded -> MODULE = (2^48 / SYSCLOCK)
#define MODULE_DOUBLE 938249.9223688533 // rounded -> MODULE = (2^48 / SYSCLOCK)
#define MODULE_PWT (pow(2, 14))



//  PTW 1 - 12 bits Phase Tunning Word

#define PTW_SIZE 2 // 2 bytes - 14 bits for phase Tunning Word.

#define PWT_1_BASE_DIR 0x00
#define PWT_1_MSB_DIR  (PWT_1_BASE_DIR + 0)
#define PWT_1_LSB_DIR  (PWT_1_BASE_DIR + 1)
//  PTW 2 - 12 bits Phase Tunning Word
#define PWT_2_MSB_DIR  (PWT_1_BASE_DIR + 2)
#define PWT_2_LSB_DIR  (PWT_1_BASE_DIR + 3)

// FTW 1 - 48 bits Frequency Tunning Word Address

#define FTW_SIZE 6 // 6 bytes - 48 bits for Freq Tunning Word.

#define FTW_1_BASE_DIR 		0x04

#define FTW_1_BYTE_F_DIR  (0x04 + 0) // MSByte
#define FTW_1_BYTE_E_DIR  (0x04 + 1)
#define FTW_1_BYTE_D_DIR  (0x04 + 2)
#define FTW_1_BYTE_C_DIR  (0x04 + 3)
#define FTW_1_BYTE_B_DIR  (0x04 + 4)
#define FTW_1_BYTE_A_DIR  (0x04 + 5) //LSByte
// FTW 2 - 12 bits Phase Tunning Word
#define FTW_2_BYTE_F_DIR  (0x04 + 6) // MSByte
#define FTW_2_BYTE_E_DIR  (0x04 + 7)
#define FTW_2_BYTE_D_DIR  (0x04 + 8)
#define FTW_2_BYTE_C_DIR  (0x04 + 9)
#define FTW_2_BYTE_B_DIR  (0x04 + 10)
#define FTW_2_BYTE_A_DIR  (0x04 + 11) //LSByte

// CONTROL REGISTER Address and BitFields
// REG1: Power Down Register
// REG2: PLL + Clock Mult Register
// REG3: Modes Register
// REG4: ByPass Inv Sinc + OSK Register
#define REG1_CTRL_BASE    0x1D // Power Down Reg

// DDS Operation Modes (OM)
#define OM_SINGLE_TONE (0x00 << 1)  // 0000-0000b
#define OM_FSK         (0x01 << 1)	// 0000-0010b
#define OM_RAMPED_FSK  (0x02 << 1)	// 0000-0100b
#define OM_CHIRP       (0x03 << 1)	// 0000-0110b
#define OM_BPSK        (0x04 << 1)	// 0000-1000b

#define REG1_CTRL_DIR     		 (REG1_CTRL_BASE + 0)// Power Down Reg
#define REG1_CTRL_BIT_DIGPD   	 (1U << 0)
#define REG1_CTRL_BIT_DACPD   	 (1U << 1)
#define REG1_CTRL_BIT_QDACPD  	 (1U << 2)
#define REG1_CTRL_BIT_COMPPD  	 (1U << 4)

#define REG2_CTRL_DIR  		 	 (REG1_CTRL_BASE + 1) // PLL - Ref Mult
#define REG2_CTRL_BIT_BYPASSPLL  (1U << 5)
#define REG2_CTRL_BIT_PLLRANGE   (1U << 6)

#define REG3_CTRL_DIR  		 	 (REG1_CTRL_BASE + 2) // Clock UD - Modes - QDAC Source - F1 to F2 Sweep - Acumulator
#define REG3_CTRL_BIT_I_E_UD     (1U << 0)
#define REG3_CTRL_BIT_MODE0      (1U << 1)
#define REG3_CTRL_BIT_MODE1      (1U << 2)
#define REG3_CTRL_BIT_MODE2      (1U << 3)
#define REG3_CTRL_BIT_SRC_QDAC   (1U << 4)
#define REG3_CTRL_BIT_TRIANGLE   (1U << 5)
#define REG3_CTRL_BIT_CLR_ACC2   (1U << 6)
#define REG3_CTRL_BIT_CLR_ACC1   (1U << 6)

#define REG4_CTRL_DIR  			(REG1_CTRL_BASE + 3) // Serial port - LSBit from Serial Port - OSK
#define REG4_CTRL_BIT_SDO           (1U << 0)
#define REG4_CTRL_BIT_LSB           (1U << 1)
#define REG4_CTRL_BIT_OSK_INT       (1U << 4)
#define REG4_CTRL_BIT_OSK_EN        (1U << 5)
#define REG4_CTRL_BIT_BYPASS_INV    (1U << 6)

// OSK I
#define OSK_I_MSB_DIR  			(REG1_CTRL_BASE + 4)// MSByte
#define OSK_I_LSB_DIR  			(REG1_CTRL_BASE + 5)// LSByte
#define OSK_MAX_AMPL_MSB_I    	0x0F
#define OSK_MAX_AMPL_LSB_I   	0xFF
// OSK Q
#define OSK_Q_MSB_DIR  			(REG1_CTRL_BASE + 6)// MSByte
#define OSK_Q_LSB_DIR  			(REG1_CTRL_BASE + 7)// LSByte
#define OSK_MAX_AMPL_MSB_Q    	0x0F
#define OSK_MAX_AMPL_LSB_Q    	0xFF
// Define control register bitfields
// ... add more control bits as needed

//ad9854 Function prototypes
void ad9854_init(uint16_t powerDownReg, uint16_t multClockReg, uint16_t modeReg, uint16_t oskReg, uint16_t op_code, uint8_t mem_offset); // Writes init data config in DDS
void ad9854_ftw_set(uint32_t freq ,  uint8_t sel_acc , uint8_t op_code, uint8_t mem_offset );// Writes ftw word in DDS
void ad9854_phase_set( uint32_t phase ,  uint8_t op_code, uint8_t mem_offset); // Writes phase word in DDS
void sinc_modulation( float pulse_width,  uint8_t op_code, uint8_t mem_offset ); // Set Sinc modulation pulse witdh

// Function prototypes
void chrono_1_32b( float time_pulse,  uint32_t op_code, uint32_t mem_offset );// Chrono to pulse ON
void chrono_2_32b( float time_pulse,  uint32_t op_code, uint32_t mem_offset );// Chrono to pulse OFF.
void pulse_pgr( uint32_t data_pgr,  uint32_t op_code , uint32_t mem_offset );// Loads program sequence buffer.

// Function prototypes freq word calc with different precision
uint8_t* freq_ftw_64b(uint32_t freq_desired, uint8_t ftw_64arch[FTW_SIZE-1]);// used by default
uint8_t* freq_convert_32b(uint32_t freq, uint8_t ftw_32arch[ FTW_SIZE-1 ] );// To use needs modify function in .c file
uint8_t* freq_double_convert(double freq, uint8_t ftw_32double[FTW_SIZE-1]);// To use needs modify function in .c file

//void multiply_bytes(unsigned char *result, const unsigned char *num1, const unsigned char *num2);

#endif // AD9854_H
