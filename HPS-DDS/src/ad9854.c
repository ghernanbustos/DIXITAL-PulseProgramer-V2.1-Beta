/*
 * 	File: ad9854.c
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


/* In future version declare subfunction for every operation
* 1 parameter for read/write buffer operation
* 				op_code = 0 writes and preload data in FPGA buffer memory
* 				op_code = 1 reads one block preload data in buffer at once.
* 				op_code = 2 Fetch preload data in buffer and writes DDS registers controlled by HPS
* This function are used by manual FPGA - DDS configuration. All data is first stored in FPGA BUFFERS and then excecuted
* to configure DDS. This function are used by parser.c when reading the machine code program to preload data and excecute
* a PULSE SEQUENCE.
*
* All op 2 except when using PGR module, are used for init buffers fsm manually.
*
* At every function write alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_INIT | HPS_ON) ); to let
* 	dds input with a defined states, for instance when using CHRONO1 to generate a square pulse, some times sinc mod is
* 	not requiered, in this case DDS input should not stay with unknoledge states.
*/

/* Think to split in smaller function or subfunction every module to make it readily*/

#include <stdio.h>
#include "../include/ad9854.h"
#include "../include/hps_0_wrapper.h"// Necessary to map Bus registers defined in Wrapper
#include "socal/socal.h"// allow access to alt_write_ or alt_read_ low level access to write registers

//************Global Variable Declaration**********************
//uint8_t ftw_64arch[5] = {0}, ftw_32arch[5] = {0},  ftw_32double[5] = {0};


/**********************************************************************
*
* Function: ad9854_init
*
* Description: Initialize DDS.
*
* Notes: 
*   This function set DDS 16bits word (Address + Setting) to be stored
*   in a Buffer Memory embedded in FPGA, then data is fetched and sequenced to 
*   ad9854 module by the use of a Finite state machine. LSB set module configuration
*   and MSB the address of the dds register. Parameters functions are 
*   half words with bits overlaped depending the configuration.
*   OSK amplitude es fixed to Max values. Not defined by user.
*   h2p_lw_wrap_ctrl / h2p_lw_wrap_address / h2p_lw_wrap_data Virtual
*   memory calculated with wrapper_mmap(). This function needs the use of the
*   mentioned function to calculate virtual memory space.
* Returns: None.
* Params:
* 	4 parameters related with dds config register
* 	1 parameter for read/write buffer operation op_code = 0 preload data in FPGA buffer memory
* 												op_code = 1 reads preloaded data in a determinated buffer position.
* 												op_code = 2 excecute preloaded data in buffer and writes DDS registers.
* 	op_code 0 and op_code 1 is controlled by HPS,
* 	op_code 2 HPS only inits fsm that sequence data to DDS, after this, expects for FSM end flag.
* 	1 parameter to set offset memory direction to access to differents memories position.
**********************************************************************/
void ad9854_init(uint16_t powerDownReg, uint16_t multClockReg, uint16_t modeReg, uint16_t oskReg, uint16_t op_code, uint8_t mem_offset )
{
	// ________________________________________________________________________
	// write routine to check mem_offset, sel_acc, freq, op_code not be out of range.
	// ________________________________________________________________________
    uint16_t configArray[INIT_SIZE];
    int memAux=0; //4 dds control regs + 4 OSK amplitud regs
    uint8_t nAddress;
    // Builds DDS configuration 16b data frame (addressReg + DataConfiguration)
    configArray[0] = (REG1_CTRL_DIR << 8) | powerDownReg;
    configArray[1] = (REG2_CTRL_DIR << 8) | multClockReg;
    configArray[2] = (REG3_CTRL_DIR << 8) | modeReg;
    configArray[3] = (REG4_CTRL_DIR << 8) | oskReg;
    // Fixed OSK regs value sets max output channel amplitude, wrong data may lead in wrong signal output
    configArray[4] = (OSK_I_MSB_DIR << 8) | OSK_MAX_AMPL_MSB_I;
    configArray[5] = (OSK_I_LSB_DIR << 8) | OSK_MAX_AMPL_LSB_I;
    configArray[6] = (OSK_Q_MSB_DIR << 8) | OSK_MAX_AMPL_MSB_Q;
    configArray[7] = (OSK_Q_LSB_DIR << 8) | OSK_MAX_AMPL_LSB_Q;

    if(op_code == 0){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_INIT | HPS_ON) ); // Prepare buffers mux to recieve data from HPS
		printf("\n Data extracted from FPGA Buffer [ddsRegAddres + data]:\n");
		for(nAddress = 0 ; nAddress <= (INIT_SIZE-1); nAddress++){ // 8 iterations
			memAux = mem_offset + nAddress;
			//
			alt_write_byte( h2p_lw_wrap_ctrl_init,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set internal buffer mux - enable RAM
			alt_write_byte( h2p_lw_wrap_address_init, memAux ); 						//Set RAM Address
			alt_write_word( h2p_lw_wrap_data_init,  configArray[nAddress] ); 			//Set RAM Data
			// Writes de RAM
			alt_write_byte( h2p_lw_wrap_ctrl_init, (RAM_EN_MASK1 | CTRL_WR_RAM | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			//Check written data in RAM buffer
			if (alt_read_word( h2p_lw_wrap_data_rd_init) == configArray[nAddress]){
				printf( "\n MemPos = %d, Data [%i]= 0x%04X",memAux, nAddress, alt_read_word( h2p_lw_wrap_data_rd_init));	//Reads 16bits
			 //printf( "\n Data oK");
			 } else  {printf( "\n Data FAIL");}
			// OFF CONTROL BITs
			alt_write_byte( h2p_lw_wrap_ctrl_init 	, CTRL_CLC_RAM); // Clear output ram
			alt_write_byte( h2p_lw_wrap_ctrl_init 	, (RAM_EN_MASK1 &  (~ (CTRL_CLC_RAM|CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals
		};

    } else if (op_code == 1){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,   (OUTMUX_INIT | HPS_ON) ); // Don't forget to set  mux regs
    	printf("Data extracted from FPGA Buffer 16bits long [ddsRegAddres + data]:\n");
		for(nAddress = 0 ; nAddress <= 7; nAddress++){
			//
			memAux = mem_offset + nAddress;
			//
			alt_write_byte( h2p_lw_wrap_ctrl_init,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set internal buffer mux to write, enable RAM
			alt_write_byte( h2p_lw_wrap_address_init, memAux ); 						//Set RAM Address
			alt_write_byte( h2p_lw_wrap_ctrl_init, (RAM_EN_MASK1 | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			printf( "\n INIT Word[%i], RAM direction [%i]= 0x%04X", nAddress, memAux,alt_read_word( h2p_lw_wrap_data_rd_init));	//Reads 16bits
		}
		alt_write_byte( h2p_lw_wrap_ctrl_init 	, CTRL_CLC_RAM); // Clear output ram
		alt_write_byte( h2p_lw_wrap_ctrl_init 	, (RAM_EN_MASK1 &  (~ (CTRL_CLC_RAM|CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off control bits

    } else if (op_code == 2){
    	// Load data from buffer to DDS ROUTINE
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_INIT | HPS_ON)); // Don't forget to set output mux to DDS
		//
		alt_write_byte( h2p_lw_wrap_address_init, mem_offset ); // // preload offset to fsm before sequencing data
		//
		alt_write_byte( h2p_lw_wrap_ctrl_init,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF ));//
		//
		alt_write_byte( h2p_lw_wrap_ctrl_init,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF| CTRL_START_FSM ));// inits fsm dds load data routine
		//
		while ( (alt_read_byte( h2p_lw_wrap_ctrl_rd_fsmflags) & INIT_FSM_END_FLAG)  == 0x00); // waits for "init" fsm end flag
		//reset fsm
		alt_write_byte( h2p_lw_wrap_ctrl_init,  (RAM_EN_MASK2));//reset fsm rdy for next dds load
		printf("\n @@@@@ DDS data load END ");
    } else {
    	printf("\n Wrong op code");
    }
}

/**********************************************************************
*
* Function: ad9854_ftw_set
*
* Description: Calls freq_ftw_64b to calc ftw word. Takes in account Fsys_dds = 300Mhz
* This value was set in clock prescaler multiplier with ad9854_init()
* FTW = (Fout × 2^N)/SYSCLK, N = 48, SYSCLK=300Mhz.
* ONLY WRITES FIRST FTW WORD - not used frequency hopping
* FTW is splitted in six 8bits words and by masking dds reg ftw addres is added
* leading to 16bit word to be written in fpga buffer memory.
*
* Notes:
* 	Explain how data is passed by reference to calc FTW, avoiding global variables.
* 	Then how to build data frame to DDS.
*
* Returns: pointer to array.
* Params:
* 	1 Desired frequency	freq ---> uint32_t variable type. only integer numbers.
* 	1 parameter to select different precision 	sel_acc = 0 - 64 bit arch
* 												sel_acc = 1 - 32 bit arch float
* 												sel_acc = 2 - 32 bit arch double float
*
* 	1 parameter for read/write buffer operation op_code = 0 - writes buffer and check
* 												op_code = 1 - reads buffer
* 												op_code = 2 - Start fsm in fpga to fetch data from buffer and writes it in DDS regs.
* 	op_code 0 and op_code 1 is controlled by HPS, op_code 2 HPS only init fsm and then internal fsm in fpga sends data to dds.
**********************************************************************/

void ad9854_ftw_set(uint32_t freq ,  uint8_t sel_acc , uint8_t op_code, uint8_t mem_offset )
{
	// ________________________________________________________________________
	// write routine to check mem_offset, sel_acc, freq, op_code not be out of range.
	// ________________________________________________________________________
    uint8_t freq_word[FTW_SIZE-1]={0};// 48bit FTW splitted in 6 bytes to individually to build Data Frames.
    uint16_t ddsArray[FTW_SIZE-1]={0}; // Data frame to store in buffers [Reg Dir + Data Word]
    uint8_t nAddress;
    int memAux=0;
    // Chose accurancy function to calc freq word 64bits, 32bits, double and print the value in console
    if(op_code == 0){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_FTW | HPS_ON) ); // Sets HPS control
//    	printf("\n\n FTW calculated - 64bit operation");
		freq_ftw_64b(freq, freq_word); // change freq_word value by reference

//		for (i = 0; i <= (FTW_SIZE-1); i++){
//			printf("\n\t FTW (64b arch)[%d] = %2X", i, freq_word[i]);
//		}
		/*if(sel_acc == 0){														// 64b operation presicion

    		printf("\n -- Operation with 64 bit arch");
    		freq_ftw_64b(freq, freq_word); // change freq_word value by reference

    		for (i = 0; i <= (FTW_SIZE-1); i++){
    			printf("\n\t FTW (64b arch)[%d] = %X", i, freq_word[i]);
    		}

        } else if (sel_acc == 1){												// 32b operation presicion
    		printf("\n -- Operation with 32 bit arch ");
    		freq_convert_32b(freq, freq_word); // change freq_word value by reference

    		for (i = 0; i <= (FTW_SIZE-1); i++){
    			printf("\n\t FTW (32b arch)[%d] = %X", i, freq_word[i]);
    		}
        } else if (sel_acc == 2){												// 32b double operation presicion
        	printf("\n -- Operation with double resol 32 bit arch");
        	freq_convert_32b(freq, freq_word); // change freq_word value by reference

    		for (i = 0; i <= (FTW_SIZE-1); i++){
    			printf("\n\t FTW (double)[%d] = %X", i, freq_word[i]);
    		}
        };*/

        // Build a 16 bits word with | RegDir + freq_word | ready to send to DDS.
        ddsArray[0] = (FTW_1_BYTE_A_DIR << 8) | freq_word[0]; //LSB freq word - High position in DDS reg -> 0x09
        ddsArray[1] = (FTW_1_BYTE_B_DIR << 8) | freq_word[1];
        ddsArray[2] = (FTW_1_BYTE_C_DIR << 8) | freq_word[2];
        ddsArray[3] = (FTW_1_BYTE_D_DIR << 8) | freq_word[3];
        ddsArray[4] = (FTW_1_BYTE_E_DIR << 8) | freq_word[4];
        ddsArray[5] = (FTW_1_BYTE_F_DIR << 8) | freq_word[5]; //MSB freq word - Low position in DDS reg -> 0x04

		printf("\n Data extracted from FPGA Buffer 16bits long [ddsRegAddres + data]:\n");
    	//
		for(nAddress = 0 ; nAddress <= (FTW_SIZE-1); nAddress++){
			memAux = mem_offset + nAddress;
			alt_write_byte( h2p_lw_wrap_ctrl_ftw,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
			alt_write_byte( h2p_lw_wrap_address_ftw, memAux ); 						//Set RAM Address
			alt_write_word( h2p_lw_wrap_data_ftw,  ddsArray[nAddress] ); 		//Set RAM Data
			// Writes de RAM
			alt_write_byte( h2p_lw_wrap_ctrl_ftw, (RAM_EN_MASK1 | CTRL_WR_RAM | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			//Data RAM buffer check Routine
			if (alt_read_word( h2p_lw_wrap_data_rd_ftw) == ddsArray[nAddress]){
				printf( "\n Direction [%i]= 0x%04X", nAddress, alt_read_word( h2p_lw_wrap_data_rd_ftw));
			 } else  {printf( "\n Data FAIL");}
			// OFF CONTROL BITs
			alt_write_byte( h2p_lw_wrap_ctrl_ftw 	, CTRL_CLC_RAM); // Clear output ram
			alt_write_byte( h2p_lw_wrap_ctrl_ftw 	, (RAM_EN_MASK1 &  (~ (CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals
		}
    } else if (op_code == 1){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_FTW | HPS_ON) ); // Sets HPS control
    	printf("\n Data extracted from FPGA Buffer 16bits long [ddsRegAddres + data]:\n");
		for(nAddress = 0 ; nAddress <= (FTW_SIZE-1); nAddress++){
			memAux = mem_offset + nAddress;
			alt_write_byte( h2p_lw_wrap_ctrl_ftw,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
			alt_write_byte( h2p_lw_wrap_address_ftw, memAux ); 						//Set RAM Address
			alt_write_byte( h2p_lw_wrap_ctrl_ftw, (RAM_EN_MASK1 | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			printf( "\n FTW[%i], RAM direction [%i]= 0x%04X",nAddress, memAux, alt_read_word( h2p_lw_wrap_data_rd_ftw));	//Reads 16bits
			}
		//
		alt_write_byte( h2p_lw_wrap_ctrl_ftw 	, CTRL_CLC_RAM); // Clear output ram
		//
		alt_write_byte( h2p_lw_wrap_ctrl_ftw 	, (RAM_EN_MASK1 &  (~ (CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals


    } else if (op_code == 2){
    	// Load data from buffer to DDS ROUTINE
    	//alt_write_byte( h2p_lw_wrap_ctrl_ftw,  (RAM_EN_MASK2));// reset fsm rdy for next dds load
		//
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_FTW | HPS_ON) ); // Sets HPS control
		//manual offset
		alt_write_byte( h2p_lw_wrap_address_ftw, mem_offset ); // preload offset to fsm before sequencing data
		//
		alt_write_byte( h2p_lw_wrap_ctrl_ftw,  (RAM_EN_MASK2|CTRL_RST_N_FSM_OFF));// time to set internal mux
		//
		alt_write_byte( h2p_lw_wrap_ctrl_ftw,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF| CTRL_START_FSM ));// inits fsm dds load data routine
		// loop to wait for fsm end flag.
		while ((alt_read_byte( h2p_lw_wrap_ctrl_rd_fsmflags) & FTW_FSM_END_FLAG) == 0x00); // waits for ftw fsm end flag
		// reset fsm
    	alt_write_byte( h2p_lw_wrap_ctrl_ftw,  (RAM_EN_MASK2));// reset fsm rdy for next dds load
		//
		printf("\n @@@@@ Data Buffer set in DDS registers ");
    };
}


/**********************************************************************
* Function phase_set
*
* Description: 
*   Calculate PTW 1 and adds register address to build a 16bit word (hword).
*   ONLY WRITES FIRST PTW WORD
*   PTW is splitted in two 8bits words and by masking dds reg ptw addres is added
* 	leading to 16bit word to be written ind fpga buffer memory.
*
* Notes: 
*       PTW_1_MSB => 0x00 + MSB
*       PTW_1_LSB => 0x01 + LSB
*
* Params:
* 	1 Desired frequency	phase
*
* 	1 parameter for read/write buffer operation op_code = 0 - writes buffer and check
* 												op_code = 1 - reads buffer
* 												op_code = 2 - Start fsm in fpga to fetch data from buffer and writes it in DDS regs.
*	op_code 0 and op_code 1 is controlled by HPS, op_code 2 HPS only init fsm and then internal fsm in fpga sends data to dds.
* Returns: None.
**********************************************************************/
void ad9854_phase_set( uint32_t phase,  uint8_t op_code ,uint8_t mem_offset) {
	// ________________________________________________________________________
	// write routine to check mem_offset, phase, op_code not be out of range.
	// ________________________________________________________________________
    uint32_t phaseWord;
    uint32_t mask = 0x000000FF;
    uint16_t ddsArray[PTW_SIZE-1]={0}; // DataBuffer = dds addres + ptw 8bits
    uint8_t nAddress;
    int memAux = 0;

//    printf("\n ::: PHASE TUNNING WORD CALCULATION :::");
//    printf("\n MODULE_PWT = %d", (uint32_t) MODULE_PWT);
    // Calculation of phase word
    phaseWord = (uint32_t)(phase * (float)(MODULE_PWT / 360)); // cast to integer.

//    printf("\n phase = %d", phase);
//    printf("\n phaseWord = %d | Hexa = %04X", phaseWord, phaseWord);

    // Build a 16 bits word with | RegDir + MSB | and | RegDir + LSB | ready to send to DDS.
    ddsArray[0] = (uint16_t)( (PWT_1_LSB_DIR << 8) | (mask & phaseWord) );		// LSB ptw
    ddsArray[1] = (uint16_t)( (PWT_1_MSB_DIR << 8) | (mask & (phaseWord >> 8)));	// MSB ptw

//    printf( "\n Data [0]= 0x%04X  LSB",ddsArray[0]);// 16bit long
//    printf( "\n Data [1]= 0x%04X  MSB",ddsArray[1]);

    if(op_code == 0){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_PTW | HPS_ON) ); // Sets HPS control
    	printf("\n Data extracted from FPGA Buffer 16bits long [ddsRegAddres + data]:\n");
		for(nAddress = 0 ; nAddress <= (PTW_SIZE-1); nAddress++){
			memAux = mem_offset + nAddress;
			 alt_write_byte( h2p_lw_wrap_ctrl_ptw,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
			 alt_write_byte( h2p_lw_wrap_address_ptw, memAux ); 						//Set RAM Address
			 alt_write_word( h2p_lw_wrap_data_ptw,  ddsArray[nAddress] ); 				//Set RAM Data
			 // Writes de RAM
			 alt_write_byte( h2p_lw_wrap_ctrl_ptw, (RAM_EN_MASK1 | CTRL_WR_RAM | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			 //Check written data in RAM buffer
			 if (alt_read_word( h2p_lw_wrap_data_rd_ptw) == ddsArray[nAddress]){
				 printf( "\n Direction [%i]= 0x%04X", nAddress, alt_read_word( h2p_lw_wrap_data_rd_ptw));	//Reads 16bits
				 //printf( "\n Data oK");
				 } else  {printf( "\n Data FAIL");}
			 // OFF CONTROL BITs
			 alt_write_byte( h2p_lw_wrap_ctrl_ptw 	, (RAM_EN_MASK1 &  (~ (CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals
		}

    } else if (op_code == 1){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_PTW | HPS_ON) ); // Sets HPS control
    	printf("\n Data extracted from FPGA Buffer 16bits long [ddsRegAddres + data]:\n");
		for(nAddress = 0 ; nAddress <= (PTW_SIZE-1); nAddress++){
			memAux = mem_offset + nAddress;
			 alt_write_byte( h2p_lw_wrap_ctrl_ptw,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
			 alt_write_byte( h2p_lw_wrap_address_ptw, memAux ); 						//Set RAM Address
			 alt_write_byte( h2p_lw_wrap_ctrl_ptw, (RAM_EN_MASK1 | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			 printf( "\n PTW[%i], Direction [%i]= 0x%04X",memAux, memAux, alt_read_word( h2p_lw_wrap_data_rd_ptw));	//Reads 16bits
			}
		 	 alt_write_byte( h2p_lw_wrap_ctrl_ptw 	, 0x00); //off control bits
    } else if (op_code == 2){
    	//alt_write_byte( h2p_lw_wrap_ctrl_ptw,  (RAM_EN_MASK2));// reset fsm rdy for next dds load
    	// Load data from buffer to DDS ROUTINE
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux, (OUTMUX_PTW | HPS_ON)); // Don't forget to set output mux to DDS
		//manual offset
		alt_write_byte( h2p_lw_wrap_address_ptw, mem_offset ); // preload offset to fsm before sequencing data
		//
		alt_write_byte( h2p_lw_wrap_ctrl_ptw,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF));// Clear FSM reset signal
		//
		alt_write_byte( h2p_lw_wrap_ctrl_ptw,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF| CTRL_START_FSM ));// inits fsm dds load data routine
		//
		while ((alt_read_byte( h2p_lw_wrap_ctrl_rd_fsmflags) & PTW_FSM_END_FLAG) == 0x00); // waits for ptw fsm end flag
		//
		alt_write_byte( h2p_lw_wrap_ctrl_ptw,  (RAM_EN_MASK2));// reset fsm rdy for next dds load
		//
		printf("\n @@@@@ Data Buffer set in DDS registers ");    } ;

}

/**********************************************************************
* Function chrono_32b
*
* Description:
*   Calculate 32bit timer pre-count to control windows width
*
* Params:
* 	1 Desired time_pulse
*
* 	1 parameter for read/write buffer operation op_code = 0 - writes buffer
* 												op_code = 1 - reads buffer position
* 												op_code = 2 - reads buffer position and inits chrono window
* 												ip_code = 3 - reads buffer position and inits chrono window but NCO output mux is enable, check
* 																MSB from first 8bits, it has to be '1' to enable mux in FPGA that allows NCO + Window RF
* Returns: None.
**********************************************************************/
void chrono_1_32b( float time_pulse,  uint32_t op_code , uint32_t chrono_address ) {
	// ________________________________________________________________________
	// write routine to check mem_offset, time_pulse, op_code not be out of range.
	// ________________________________________________________________________
    uint32_t preload_32word;
    float predata;

    // Counter prescaler value calculation.
    //predata =  time_pulse * ((float) FPGA_CLK_50);
    //preload_32word = (uint32_t)( ((float) COUNTER_MODULE) - predata); // 32bit timer in fpga chrono module with a 50Mhz clock

   if ( (op_code > 3) || (time_pulse >= 85) || (chrono_address >= 64) ) {
        	printf("\n -- Some function parameter is out of range ");

	} else if(op_code == 0){
		//=====================================
	    predata =  time_pulse * ((float) FPGA_CLK_50);
	    preload_32word = (uint32_t)( ((float) COUNTER_MODULE) - predata); // 32bit timer in fpga chrono module with a 50Mhz clock
	    //=====================================
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (HPS_ON | OUTMUX_CHRONO1) ); // No output DDS mux  used
		printf("\n Data extracted from FPGA Buffer 32bits long:\n");
		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
		alt_write_byte( h2p_lw_wrap_address_chrono, chrono_address ); 				//Set RAM Address
		alt_write_word( h2p_lw_wrap_data_chrono,  preload_32word ); 				//Set RAM Data
		// Writes de RAM
		alt_write_byte( h2p_lw_wrap_ctrl_chrono, (RAM_EN_MASK1 | CTRL_WR_RAM | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
		//Check written data in RAM buffer
		if (alt_read_word( h2p_lw_wrap_data_rd_chrono) == preload_32word){
		 printf( "\n Direction [%i]= 0x%08X", chrono_address, alt_read_word( h2p_lw_wrap_data_rd_chrono));	//Reads 16bits
		 } else  {printf( "\n Data FAIL");
		// OFF CONTROL BITs
		alt_write_byte( h2p_lw_wrap_ctrl_chrono 	, (RAM_EN_MASK1 &  (~ (CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals
		}

    } else if (op_code == 1){
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (HPS_ON | OUTMUX_CHRONO1) ); // No output DDS mux  used
		printf("\n Data extracted from FPGA Buffer 32bits long:\n");
		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
		alt_write_byte( h2p_lw_wrap_address_chrono, chrono_address ); 						//Set RAM Address
		alt_write_byte( h2p_lw_wrap_ctrl_chrono, (RAM_EN_MASK1 | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
		printf( "\n Direction [%i]= 0x%08X", chrono_address, alt_read_word( h2p_lw_wrap_data_rd_chrono));	//Reads 32bits
		alt_write_byte( h2p_lw_wrap_ctrl_chrono 	, 0x00); //off control bits


    } else if (op_code == 2){  // Only access to a buffer position, fetch data and inits chrono.
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (HPS_ON | OUTMUX_CHRONO1) ); // Set Mux with HPS control, address and data signal.
		//manual offset
//		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK2));// RESET fsm rdy for next load
		//
		alt_write_byte( h2p_lw_wrap_address_chrono, chrono_address ); // Set value in the FSM offset input port to access the right  mem position.
		//
		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF));// Clear FSM reset signal
		//
		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF| CTRL_START_FSM ));// inits fsm dds load data routine
		//
		while ((alt_read_byte( h2p_lw_wrap_ctrl_rd_fsmflags) & CHRONO_1_FSM_END_FLAG) == 0x00); // waits for chrono fsm end flag
		//
		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK2));// reset fsm rdy for next load
//		printf("\n -- Data Buffer set in DDS registers ");

    } else if (op_code == 3){  // Enables Chrono1 and NCO module
    		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_MOD | HPS_ON) ); // Set Mux with HPS control, address and data signal.
    		//manual offset
    //		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK2));// RESET fsm rdy for next load
    		//
    		alt_write_byte( h2p_lw_wrap_address_chrono, (chrono_address | NCO_PLUS_CHRONO_ON) ); // On NCO plus WindowRf from Chrono1 to controls enable SincModulation.
    		//
    		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF));// Clear FSM reset signal
    		//
    		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF| CTRL_START_FSM ));// inits fsm dds load data routine
    		//
    		while ((alt_read_byte( h2p_lw_wrap_ctrl_rd_fsmflags) & CHRONO_1_FSM_END_FLAG) == 0x00); // waits for chrono fsm end flag
    		//
    		alt_write_byte( h2p_lw_wrap_ctrl_chrono,  (RAM_EN_MASK2));// reset fsm rdy for next load
    //		printf("\n -- Data Buffer set in DDS registers ");

        }

   ;


}

/**********************************************************************
* Function chrono2_32b
*
* Description:
*   Calculate 32bit timer pre-count to control windows width
*
* Params:
* 	1 Desired time_pulse
*
* 	1 parameter for read/write buffer operation op_code = 0 - writes buffer
* 												op_code = 1 - reads buffer position
* 												op_code = 2 - reads buffer position and inits chrono off window time
* Returns: None.
**********************************************************************/
void chrono_2_32b( float time_pulse,  uint32_t op_code , uint32_t chrono_address ) {
	// ________________________________________________________________________
	// write routine to check mem_offset, time_pulse not be out of range.
	// ________________________________________________________________________
    uint32_t preload_32word2;
    float predata2;

    // Counter prescaler value calculation.
    predata2 = time_pulse * ((float) FPGA_CLK_50);
    preload_32word2 = (uint32_t)(((float) COUNTER_MODULE) -   predata2); // 32bit timer in fpga chrono module with a 50Mhz clock

    if ( (op_code > 2) || (time_pulse >= 85) || (chrono_address >= 64) ) {
        	printf("\n -- Some function parameter is out of range ");

	} else if(op_code == 0){
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (HPS_ON | OUTMUX_CHRONO2)); // No output DDS mux  used
		printf("\n Data extracted from FPGA Buffer 32bits long:\n");
		alt_write_byte( h2p_lw_wrap_ctrl_chrono2,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
		alt_write_byte( h2p_lw_wrap_address_chrono2, chrono_address ); 				//Set RAM Address
		alt_write_word( h2p_lw_wrap_data_chrono2,  preload_32word2 ); 				//Set RAM Data
		// Writes de RAM
		alt_write_byte( h2p_lw_wrap_ctrl_chrono2, (RAM_EN_MASK1 | CTRL_WR_RAM | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
		//Check written data in RAM buffer
		printf( "\n Direction [%i]= 0x%08X", chrono_address, alt_read_word( h2p_lw_wrap_data_rd_chrono2));	//Reads 16bits
		// check coincidence with data written in RAM.
		if (alt_read_word( h2p_lw_wrap_data_rd_chrono2) == preload_32word2){
		//				 printf( "\n Data oK \n");
		 } else  {printf( "\n Data FAIL");
		// OFF CONTROL BITs
		alt_write_byte( h2p_lw_wrap_ctrl_chrono2 	, (RAM_EN_MASK1 &  (~ (CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals
		}
    } else if (op_code == 1){
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (HPS_ON | OUTMUX_CHRONO2) ); // No output DDS mux  used
		printf("\n Data extracted from FPGA Buffer 32bits long:\n");
		alt_write_byte( h2p_lw_wrap_ctrl_chrono2,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
		alt_write_byte( h2p_lw_wrap_address_chrono2, chrono_address ); 						//Set RAM Address
		alt_write_byte( h2p_lw_wrap_ctrl_chrono2, (RAM_EN_MASK1 | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
		printf( "\n Direction [%i]= 0x%08X", chrono_address, alt_read_word( h2p_lw_wrap_data_rd_chrono2));	//Reads 32bits
		alt_write_byte( h2p_lw_wrap_ctrl_chrono2 	, 0x00); //off control bits
    } else if (op_code == 2){  // Only access to a buffer position, fetch data and inits chrono.
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (HPS_ON | OUTMUX_CHRONO2) ); // No output DDS mux  used
    														// Init buffer data sequencing to chrono, expect for fsm end flag
    	//manual offset
    	alt_write_byte( h2p_lw_wrap_address_chrono2, chrono_address ); // Set value in the FSM offset input port to access the right  mem position.
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_chrono2,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF));// Clear FSM reset signal
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_chrono2,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF| CTRL_START_FSM ));// inits fsm dds load data routine
    	//
		while ((alt_read_byte( h2p_lw_wrap_ctrl_rd_fsmflags) & CHRONO_2_FSM_END_FLAG) == 0x00); // waits for chrono fsm end flag
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_chrono2,  (RAM_EN_MASK2));// reset fsm rdy for next load
		//printf("\n -- Data Buffer set in DDS registers ");

    };
}

/**********************************************************************
* Function sinc_modulation
*
* Description:
*   Calculate 32bit phase_incr to control windows width in Sinc modulation
*   When data buffer is set in NCO the modulation begins but after reset DDS OSK
*   register are not reset to max value, this can cause not to see carrier signal.
*   Initialization might be needed to set all OSK registers in max amplitude.
*
* Params:
* 	1 Desired time_pulse
*
* 	1 parameter for read/write buffer operation op_code = 0 - writes buffer
* 												op_code = 1 - reads buffer
* 												op_code = 2 - sets buffer data and inits modulation.
* 												op_code = 3 - stops modulation, OSK registers are not reset to max value.
* Returns: None.
**********************************************************************/
void sinc_modulation( float pulse_width,  uint8_t op_code, uint8_t sinc_address ) {

    uint32_t phase_incr;

    phase_incr = (uint32_t)((float)(NCO_MODULE / (NCO_CLK_3 * pulse_width)) + 0.5);
    //phase_incr = 71582788; // Fixed Value set in pulseq demo. 20uS window width

    //printf( "\n pulse_width [%.6f]", pulse_width);	//Reads 16bits
	//printf( "\n phase_incr  [%u] = 0x%08X",phase_incr, phase_incr);


    if(op_code == 0){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_MOD | HPS_ON) ); // No output DDS mux  used
		printf("\n Data extracted from FPGA Buffer 32bits long:\n");
			 alt_write_byte( h2p_lw_wrap_ctrl_modulation,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
			 //
			 alt_write_byte( h2p_lw_wrap_address_modulation, sinc_address ); 						//Set RAM Address
			 //
			 alt_write_word( h2p_lw_wrap_data_modulation,  phase_incr ); 				//Set RAM Data
			 // Writes de RAM
			 alt_write_byte( h2p_lw_wrap_ctrl_modulation, (RAM_EN_MASK1 | CTRL_WR_RAM | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			 //Check written data in RAM buffer
			 if (alt_read_word( h2p_lw_wrap_data_rd_modulation) == phase_incr){
				 printf( "\n Direction [%i]= 0x%08X", sinc_address, alt_read_word( h2p_lw_wrap_data_rd_modulation));
				 } else  printf( "\n Data FAIL");
			 // OFF CONTROL BITs
			 alt_write_byte( h2p_lw_wrap_ctrl_modulation 	, (RAM_EN_MASK1 &  (~ (CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals RAM_EN_MASK1 = off.
		}

     else if (op_code == 1){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (OUTMUX_MOD | HPS_ON) ); // No output DDS mux  used
		printf("\n -- Reads data stored in buffer for checking recorded data ");
			 alt_write_byte( h2p_lw_wrap_ctrl_modulation,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
			 //
			 alt_write_byte( h2p_lw_wrap_address_modulation, sinc_address ); 						//Set RAM Address
			 //
			 alt_write_byte( h2p_lw_wrap_ctrl_modulation, (RAM_EN_MASK1 | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			 //
			 printf( "\n Direction [%i]= 0x%08X", sinc_address, alt_read_word( h2p_lw_wrap_data_rd_modulation));	//Reads 16bits

		 	 alt_write_byte( h2p_lw_wrap_ctrl_modulation 	, 0x00); //off control bits

    } else if (op_code == 2){
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux, (OUTMUX_MOD | HPS_ON) ); // Set OutputMux
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_modulation,  (RAM_EN_MASK2)); // Set mux for fsm buffer control and reset fsm
    	//
    	//manual offset
    	alt_write_byte( h2p_lw_wrap_address_modulation, sinc_address );
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_modulation,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF));// Clear FSM reset signal
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_modulation,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF| CTRL_START_FSM ));// inits fsm dds load data routine
    	// If it used Sinc modulation does not work.
    	while (alt_read_byte( h2p_lw_wrap_ctrl_rd_fsmflags) != SINC_MOD_FSM_END_FLAG); // waits for ftw fsm end flag
    	//
		//printf("\n -- Data set in DDS registers ");

    }  else if (op_code == 3){
		printf("\n -- Reset FSM - Stop Sinc Modulation ");
		alt_write_byte( h2p_lw_wrap_ctrl_modulation,  (RAM_EN_MASK2));// reset fsm modulation sequence, the output signal might be off in amplitude
																	// or the last value  during modulation, this resent does not ensure max amplitude in output.

    }


}


/**********************************************************************
* Function pulse_pgr
*
* Description:
*   Loads program sequence software.
*   In op_code = 2, HPS only access to control pulse_fsm, all buffers are controlled by puslse fsm
*   extracting 32bit word from pgr buffer, which contains op_code and data buffer address. Fsm pulse
*   takes the controls of each module.
*
* Params:
* 	1 Desired pulse_pgr
*
* 	1 parameter for read/write buffer operation op_code = 0 - writes buffer HPS controls pgr module
* 												op_code = 1 - reads buffer  HPS controls pgr module
* 												op_code = 2 - reads buffer memory and writes dds registers, HPS only inits PGR module to sequence data
* Returns: None.
**********************************************************************/
void pulse_pgr( uint32_t data_pgr,  uint32_t op_code , uint32_t pgr_address ) {

	int nAddress, dataReset = 0x00000000;

    if ( (op_code > 3) || (pgr_address >= 64) ) {
        	printf("\n -- Some function parameter is out of range ");

	} else if(op_code == 0){
		//
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (HPS_ON | OUTMUX_PGR) ); // Set defined input state in DDS
		//
		alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
		alt_write_byte( h2p_lw_wrap_address_pulsePgr, pgr_address ); 					//Set RAM Address
		alt_write_word( h2p_lw_wrap_data_pulsePgr,  data_pgr ); 						//Set RAM Data
		// Writes de RAM
		alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr, (RAM_EN_MASK1 | CTRL_WR_RAM | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
		//Check written data in RAM buffer
		if (alt_read_word( h2p_lw_wrap_data_rd_pulsePgr) == data_pgr){
			printf( "\n Direction [%i]= %08X", pgr_address, alt_read_word( h2p_lw_wrap_data_rd_pulsePgr));
		 } else  printf( "\n Data Loading FAIL!\n");
		// OFF CONTROL BITs
		alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr 	, (RAM_EN_MASK1 &  (~ (CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals

    } else if (op_code == 1){
		alt_write_byte( h2p_lw_wrap_ctrl_outmux,  (HPS_ON | OUTMUX_PGR) ); // Set defined input state in DDS
		printf("\n -- Reads data stored in buffer for checking recorded data ");
		alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
		alt_write_byte( h2p_lw_wrap_address_pulsePgr, pgr_address ); 						//Set RAM Address
		alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr, (RAM_EN_MASK1 | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
		printf( "\n Direction [%i]= %08X", pgr_address, alt_read_word( h2p_lw_wrap_data_rd_pulsePgr));	//Reads 32bits
		alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr 	, 0x00); //off control bits

    } else if (op_code == 2){  // pulse program controls all buffers, HPS only access to start or reset pgr module.
    	alt_write_byte( h2p_lw_wrap_ctrl_outmux,  PULSE_PGR_ON ); // PGR PULSE controls buffer modules
    	//manual offset
//    	alt_write_byte( h2p_lw_wrap_address_pulsePgr, pgr_address ); // Set value in the FSM offset input port to access the right  mem position.
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF));// Clear FSM reset signal
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr,  (RAM_EN_MASK2 |CTRL_RST_N_FSM_OFF| CTRL_START_FSM ));// inits fsm dds load data routine																							// signal needs to be high enough time to be sampled by fpga fsm clock_50.
    	//
		while ((alt_read_byte( h2p_lw_wrap_ctrl_rd_fsmflags) & PGR_PULSE_FSM_END_FLAG) == 0x00); // waits for pgr fsm end flag
    	//
    	alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr,  (RAM_EN_MASK2));// reset fsm rdy for next load
		printf("\n -- PROGRAM SEQUENCE END ");

    } else if (op_code == 3){
    	for(nAddress = 0 ; nAddress <= (PGR_RAM_DEEP-1); nAddress++){
			alt_write_byte( h2p_lw_wrap_ctrl_outmux,  HPS_ON ); // No output DDS mux  used
			alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr,  (RAM_EN_MASK1 | CTRL_EN_RAM )); 	//Set mux1 to write and mux0 to read , enable RAM
			alt_write_byte( h2p_lw_wrap_address_pulsePgr, nAddress ); 					//Set RAM Address
			alt_write_word( h2p_lw_wrap_data_pulsePgr,  dataReset ); 						//Set RAM Data
			// Writes de RAM
			alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr, (RAM_EN_MASK1 | CTRL_WR_RAM | CTRL_RD_RAM ) ); //Set RDW (Read During Write) and Keeps MUXs/en_ram
			//Check written data in RAM buffer
			if (alt_read_word( h2p_lw_wrap_data_rd_pulsePgr) == dataReset){
				printf( "\n Data [%i] Erased",nAddress);
			 } else  printf( "\n Erase Data FAIL!\n");
			// OFF CONTROL BITs
			alt_write_byte( h2p_lw_wrap_ctrl_pulsePgr 	, (RAM_EN_MASK1 &  (~ (CTRL_EN_RAM | CTRL_WR_RAM | CTRL_RD_RAM  )))); //off WR-RD-EN signals
		}
    	}
}






/**********************************************************************
* Function: freq_ftw_64b
*
* Description:
*   Calculate FTW word and send to FPGA buffer memory then a FSM start
*   signal initiate data transfer  parallel protocol to DDS and update changes.
*
* Notes:
*   This function does not round the decimal part of the number calculated
*   in SYSCLOCK = DDS clock 300Mhz. Take this in account if precision in frequency might be affected. The
*   48 bits ftw_A word is splited in six 8bits to assign ftw_A word address register each.
* Returns: None.
**********************************************************************/
uint8_t* freq_ftw_64b(uint32_t freq_desired, uint8_t ftw_64arch[FTW_SIZE-1]){
    //uint8_t i = 0;
    uint64_t ftw_A; // (unsigned long long)  data type

    ftw_A = (uint64_t)(((uint64_t)freq_desired )*((double) MODULE_DOUBLE)); // FTW = 48 bits long check if 32bit system can handle it
    //printf("\n ftw_A = 0x%0X", ftw_A);

    ftw_64arch[0] = (uint8_t)(ftw_A);
    ftw_64arch[1] = (uint8_t)(ftw_A >> 8 );
    ftw_64arch[2] = (uint8_t)(ftw_A >> 16);
    ftw_64arch[3] = (uint8_t)(ftw_A >> 24);
    ftw_64arch[4] = (uint8_t)(ftw_A >> 32);
    ftw_64arch[5] = (uint8_t)(ftw_A >> 40);
/*
		for (i = 0; i <= 6; i++){
			printf("\n ftw_B[%d] = %X", i, ftw_64arch[i]);
		}
*/
	return ftw_64arch;
}

/**********************************************************************
* Function CHINESE FOOD: freq_convert_32b
*
* Description:
*   Calculate FTW word in 32bit architecture
*
* Returns: None.
**********************************************************************/

uint8_t* freq_convert_32b(uint32_t freq, uint8_t  ftw_32arch[ FTW_SIZE-1 ] )
{
    uint32_t FreqBuf = 0;
    uint8_t i, count = 6;
    uint8_t Array_Freq[4]; //Split the input frequency factor into four bytes" in English.

	printf("\n Freq Value: %d | %#014x",freq, freq);

    Array_Freq[0] = (uint8_t) freq;
    Array_Freq[1] = (uint8_t)(freq >> 8);
    Array_Freq[2] = (uint8_t)(freq >> 16);
    Array_Freq[3] = (uint8_t)(freq >> 24);// after this operations Freq variable is no longer
                                          // the same.
/*
		printf("\n Freq splitted in 8bit char variable Array_Freq\n");
		for (i = 0; i < 4; i++){
			printf("\n Array_Freq[%d] = %X    | %d", i, Array_Freq[i], Array_Freq[i]);
		}
		printf("\n ");
*/

    FreqBuf += (MODULE * Array_Freq[0]); //MODULE = 938250
    ftw_32arch[0] = (uint8_t)FreqBuf;
    FreqBuf >>= 8;
    //printf("\n FreqBuf (0)= %d | %X",FreqBuf,FreqBuf);
    FreqBuf += (MODULE * Array_Freq[1]);
    ftw_32arch[1] = (uint8_t)FreqBuf;
    FreqBuf >>= 8; // divide by 2^8=256
    FreqBuf += (MODULE * Array_Freq[2]);
    ftw_32arch[2] = (uint8_t)FreqBuf;
    FreqBuf >>= 8;
    FreqBuf += (MODULE * Array_Freq[3]);
    ftw_32arch[3] = (uint8_t)FreqBuf;
    FreqBuf >>= 8;
    ftw_32arch[4] = (uint8_t)FreqBuf;
    ftw_32arch[5] = (uint8_t)(FreqBuf >> 8);

	printf("\n ");
	for (i = 0; i < count; i++){
		printf("\n FTW[%d] = %X", i, ftw_32arch[i]);
		}
	return ftw_32arch;
}

uint8_t* freq_double_convert(double freq,  uint8_t  ftw_32double[FTW_SIZE-1])
{
    //uint8_t ftw_32double[5];
    uint32_t Low32;
    uint16_t High16;
    uint8_t i, count = 5;
    //double Freq_mult_double = 938249.9223688533;
    double Temp = MODULE_DOUBLE ;   	          //23ca99 is 2 to the power of 48 divided by 120M
    freq *= (double)(Temp); // Freq = Freq * (double)Temp 	1 0000 0000 0000 0000 0000 0000 0000 0000 = 4294967295
    High16 = (int)(freq / 4294967295);                //2^32 = 4294967295
    freq -= (double)High16 * 4294967295;
    Low32 = (uint32_t)freq;

    ftw_32double[0] = (uint8_t)  Low32;
    ftw_32double[1] = (uint8_t) (Low32 >> 8);
    ftw_32double[2] = (uint8_t) (Low32 >> 16);
    ftw_32double[3] = (uint8_t) (Low32 >> 24);
    //
    ftw_32double[4] =  (uint8_t) High16;
    ftw_32double[5] =  (uint8_t) High16 >> 8;

	printf("\n Frequency (double): %lf ",freq);
	for (i = 0; i < count; i++){
		printf("\n FTW (double)[%d] = %X", i, ftw_32double[i]);
	}
	return ftw_32double;

}
