/*
 * 	File: hps_0_wrapper.h
 *
 * 	Description:
 *	 Wrapper register defines
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

#ifndef _HPS_0_WRAPPER_H_
#define _HPS_0_WRAPPER_H_


#include <stdint.h>
#include "../lib/hps_0.h"

// - Declare global variables using extern if they need to be shared across multiple files
// control bus 'ctrl' address bus 'address' and data bus 'data'
extern volatile uint8_t *h2p_lw_wrap_ctrl_init,
							*h2p_lw_wrap_ctrl_ftw,
							*h2p_lw_wrap_ctrl_ptw,
							*h2p_lw_wrap_ctrl_chrono,
							*h2p_lw_wrap_ctrl_modulation,
							*h2p_lw_wrap_ctrl_wr_db,
							*h2p_lw_wrap_ctrl_outmux,
							*h2p_lw_wrap_ctrl_rd_fsmflags,
							*h2p_lw_wrap_ctrl_rd_db,
							*h2p_lw_wrap_ctrl_chrono2,
							*h2p_lw_wrap_ctrl_adc,
							*h2p_lw_wrap_ctrl_pulsePgr,

							*h2p_lw_wrap_ctrl_base; // Declare and initialize


extern volatile uint8_t *h2p_lw_wrap_address_init,
							*h2p_lw_wrap_address_ftw,
							*h2p_lw_wrap_address_ptw,
							*h2p_lw_wrap_address_chrono,
							*h2p_lw_wrap_address_modulation,
							*h2p_lw_wrap_address_rd_db,
							*h2p_lw_wrap_address_chrono2,
							*h2p_lw_wrap_address_adc,
							*h2p_lw_wrap_address_pulsePgr,

							*h2p_lw_wrap_address_base;


extern volatile uint32_t *h2p_lw_wrap_data_init,
							*h2p_lw_wrap_data_ftw,
							*h2p_lw_wrap_data_ptw,
							*h2p_lw_wrap_data_chrono,
							*h2p_lw_wrap_data_modulation,
							*h2p_lw_wrap_data_db,
							*h2p_lw_wrap_data_chrono2,
							*h2p_lw_wrap_data_adc,
							*h2p_lw_wrap_data_pulsePgr,

							*h2p_lw_wrap_data_rd_init,
							*h2p_lw_wrap_data_rd_ftw,
							*h2p_lw_wrap_data_rd_ptw,
							*h2p_lw_wrap_data_rd_chrono,
							*h2p_lw_wrap_data_rd_modulation,
							*h2p_lw_wrap_data_rd_db,
							*h2p_lw_wrap_data_rd_chrono2,
							*h2p_lw_wrap_data_rd_adc,
							*h2p_lw_wrap_data_rd_pulsePgr,

							*h2p_lw_wrap_data_base;

// Be aware when mapping AXIS BUS registers and Wrapper positions, check if data is 8, 16 or 32 bits long
// wrong calc in memory position might couse Alignment Trap issue while executing program.
// If 32 bit bus or variable is created in wrapper, addressing the next 32 bit bus means adding 4byte to the base position.
// if 8 bit bus or variable is created in wrapper, addressing the next 8 bit bus means adding 1byte to the base position.
// In this project Control and Address Buses are byte length, each position is accessed adding 1byte to the base address.
// For Data, buses are 32 bit lenght, 4 bytes, to access each position 4 bytes needs to be added to base address.

#define ALIGN_WORD	4 // for right register memory access
#define ALIGN_BYTE	1
/****************************************************************************************
 * Wrapper Control register address
 * 8 Bit register - Fields described
 * | MSB 																		   LSB	  |
 * | rd_rw_mux	| 	x 	| rst_n_fsm | start_fsm | clc_ram | en_ram | wr_ram | rd_ram |
 * Check Wrapper VHDL code and project Schematic connection in Quartus for further information
 */
// To set offsets checks VHDL file

#define WRAPPER_CTRL_BASE			WRAPPER_CTRL_0_BASE

#define WRAPPER_WR_CTRL_INIT_REG       (0 * ALIGN_BYTE)
#define WRAPPER_WR_CTRL_FTW_REG        (1 * ALIGN_BYTE)
#define WRAPPER_WR_CTRL_PTW_REG        (2 * ALIGN_BYTE)
#define WRAPPER_WR_CTRL_CHRONO_REG     (3 * ALIGN_BYTE)
#define WRAPPER_WR_CTRL_MODULATION_REG (4 * ALIGN_BYTE)
#define WRAPPER_WR_CTRL_DB_REG   	   (5 * ALIGN_BYTE) // Extra port for debugging purpose
#define WRAPPER_WR_CTRL_OUTMUX_REG     (6 * ALIGN_BYTE) // Output multiplexer
#define WRAPPER_WR_CTRL_CHRONO2_REG    (7 * ALIGN_BYTE) //
#define WRAPPER_WR_CTRL_ADC_REG        (8 * ALIGN_BYTE) //
#define WRAPPER_WR_CTRL_PULSEPGR_REG   (9 * ALIGN_BYTE) //

// Control register Buses directions to read

#define WRAPPER_RD_CTRL_FSM_FLAGS_REG   (0 * ALIGN_BYTE) // debug purpose
#define WRAPPER_RD_CTRL_DB_REG       	(1 * ALIGN_BYTE) // debug purpose

//---
/*
 * Bit Mask for setting Module Control Register, fixed configurations
 */
// For writing data to RAM and reads the output
#define REG_8B_MASK0   0x00 // All disable
#define RAM_EN_MASK1   0x04 // Set mux HPS master writes/reads RAM - en RAM
#define RAM_EN_MASK2   0x80 // Set mux FSM master RAM and writes DDS


//Bit access setting for set individual config
#define CTRL_RD_RAM    (1U << 0)
#define CTRL_WR_RAM    (1U << 1)
#define CTRL_EN_RAM    (1U << 2)
#define CTRL_CLC_RAM   (1U << 3)
#define CTRL_START_FSM (1U << 4)
#define CTRL_RST_N_FSM_OFF (1U << 5) // Set reset off
#define CTRL_MUX_0     (0x01 << 6) // Set HPS to RAM and returns the output to HPS
#define CTRL_MUX_1     (0x10 << 6) // Set FSM to ctrl RAM and sequence data to DDS

// Output Mux Reg / h2p_lw_wrap_ctrl_outmux/ - |hps - pulse_pgr|mod_2|mod_1|mod_0|
// In FPGA, output mux, the ones connects buffers with dds always has to define dds input ports states
// 		to avoid undesired behaviour in DDS.
#define OUTMUX_INIT 	0x00 // init bus multiplexed to dds
#define OUTMUX_FTW		0x01 // ftw bus multiplexed to dds
#define OUTMUX_PTW		0x02 // ptw bus multiplexed to dds
#define OUTMUX_CHRONO1	0x03 // modulation module multiplexed to dds
#define OUTMUX_MOD		0x04 // modulation module multiplexed to dds
#define OUTMUX_CHRONO2	0x05 // modulation module multiplexed to dds
#define OUTMUX_PGR		0x06 // modulation module multiplexed to dds
#define OUTMUX_ADC		0x07 // modulation module multiplexed to dds

#define HPS_ON			(0U << 3) // Set '0' at fourth position for HPS master
#define PULSE_PGR_ON	(1U << 3) // Set '1' at fourth position for pulse_pgr master

// To read flag state from FSM embedded in FPGA. Everytime FSM sequence data from buffers
// and finish the process, set a bit flag high to be read accessing to the corresponding bit field
// in wrapper register.
#define INIT_FSM_END_FLAG   	(1U << 0)
#define FTW_FSM_END_FLAG    	(1U << 1)
#define PTW_FSM_END_FLAG    	(1U << 2)
#define CHRONO_1_FSM_END_FLAG	(1U << 3)
#define SINC_MOD_FSM_END_FLAG 	(1U << 4)
#define CHRONO_2_FSM_END_FLAG 	(1U << 5)
#define ADC_FSM_END_FLAG 		(1U << 6)
#define PGR_PULSE_FSM_END_FLAG 	(1U << 7)

/****************************************************************************************
 * Wrapper Address register address
 * */
#define WRAPPER_ADDRESS_BASE 		  WRAPPER_ADDRESS_0_BASE

#define WRAPPER_WR_ADDRESS_INIT_REG       (0 * ALIGN_BYTE)
#define WRAPPER_WR_ADDRESS_FTW_REG        (1 * ALIGN_BYTE)
#define WRAPPER_WR_ADDRESS_PTW_REG        (2 * ALIGN_BYTE)
#define WRAPPER_WR_ADDRESS_CHRONO_REG     (3 * ALIGN_BYTE)
#define WRAPPER_WR_ADDRESS_MODULATION_REG (4 * ALIGN_BYTE)
#define WRAPPER_WR_ADDRESS_CHRONO2_REG    (5 * ALIGN_BYTE) //
#define WRAPPER_WR_ADDRESS_ADC_REG        (6 * ALIGN_BYTE) //
#define WRAPPER_WR_ADDRESS_PULSEPGR_REG   (7 * ALIGN_BYTE) //
// Address register Buses directions to read
#define WRAPPER_RD_ADDRESS_DB  			  (0 * ALIGN_BYTE) // Extra port for debugging purpose

/****************************************************************************************
 * Wrapper Data register address
 * */
// Data register Buses directions to write

#define WRAPPER_DATA_BASE 			WRAPPER_DATA_0_BASE

#define WRAPPER_WR_DATA_INIT_REG       (0 * ALIGN_WORD) //BYTE_ALIGN_WORD -> 32bits long
#define WRAPPER_WR_DATA_FTW_REG        (1 * ALIGN_WORD)
#define WRAPPER_WR_DATA_PTW_REG        (2 * ALIGN_WORD)
#define WRAPPER_WR_DATA_CHRONO_REG     (3 * ALIGN_WORD)
#define WRAPPER_WR_DATA_MODULATION_REG (4 * ALIGN_WORD)
#define WRAPPER_WR_DATA_DB_REG   	   (5 * ALIGN_WORD) // Extra port for debugging purpose
#define WRAPPER_WR_DATA_CHRONO2_REG    (6 * ALIGN_WORD) //
#define WRAPPER_WR_DATA_ADC_REG        (7 * ALIGN_WORD) //
#define WRAPPER_WR_DATA_PULSEPGR_REG   (8 * ALIGN_WORD) //
// Data register Buses directions to read

#define WRAPPER_RD_DATA_INIT_REG       (0 * ALIGN_WORD)
#define WRAPPER_RD_DATA_FTW_REG        (1 * ALIGN_WORD)
#define WRAPPER_RD_DATA_PTW_REG        (2 * ALIGN_WORD)
#define WRAPPER_RD_DATA_CHRONO_REG     (3 * ALIGN_WORD)
#define WRAPPER_RD_DATA_MODULATION_REG (4 * ALIGN_WORD)
#define WRAPPER_RD_DATA_DB_REG    	   (5 * ALIGN_WORD) // Extra port for debugging purpose
#define WRAPPER_RD_DATA_CHRONO2_REG    (6 * ALIGN_WORD) //
#define WRAPPER_RD_DATA_ADC_REG        (7 * ALIGN_WORD) //
#define WRAPPER_RD_DATA_PULSEPGR_REG   (8 * ALIGN_WORD) //

//***************************************************************



//Function Prototype
int 	fd_open ();
int  	mmap_virtual ();
int 	munmap_virtual();
void 	fd_close();
void 	wrapper_mmap();

#endif /*_HPS_0_WRAPPER_H_ */
