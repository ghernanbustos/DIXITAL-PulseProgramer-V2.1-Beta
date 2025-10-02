/*
 * 	File: hps_0_wrapper.c
 *
 * 	Description:
 *   Source file with Virtual Memory Mapping and wrapper register address
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

#include <stdio.h> 
#include <fcntl.h>
#include <sys/mman.h>  //memory management in Unix-like operating systems. https://linux.die.net/man/2/munmap
#include "hwlib.h"
#include "socal/hps.h" // Contains Defines
#include "../include/hps_0_wrapper.h"


// Base address register calculation
#define HW_REGS_BASE ( ALT_STM_OFST ) // ALT_STM_OFST= 0xfc000000 Region Peripheral
#define HW_REGS_SPAN ( 0x04000000 ) // HW_REGS_BASE + HW_REGS_SPAN = All perfipherals address space
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 ) // to avoid overflow or segmentation fault


// pointers to wrapper registers in vhdl ipcore -Always initialize pointers to NULL or a valid memory address.
// Ctrl wrapper module registers pointers 8bit type take this in account for the right pointer arithmetic
volatile uint8_t *h2p_lw_wrap_ctrl_init = NULL,*h2p_lw_wrap_ctrl_ftw = NULL,*h2p_lw_wrap_ctrl_ptw = NULL,
					*h2p_lw_wrap_ctrl_chrono = NULL,*h2p_lw_wrap_ctrl_modulation = NULL,*h2p_lw_wrap_ctrl_wr_db = NULL,
					*h2p_lw_wrap_ctrl_outmux = NULL, *h2p_lw_wrap_ctrl_rd_fsmflags = NULL,*h2p_lw_wrap_ctrl_rd_db = NULL, // Declare and initialize
					*h2p_lw_wrap_ctrl_chrono2 = NULL, *h2p_lw_wrap_ctrl_adc = NULL, *h2p_lw_wrap_ctrl_pulsePgr = NULL,
					*h2p_lw_wrap_ctrl_base = NULL;

// Address wrapper module registers pointers 8bit type take this in account for the right pointer arithmetic
volatile uint8_t *h2p_lw_wrap_address_init = NULL,*h2p_lw_wrap_address_ftw = NULL,*h2p_lw_wrap_address_ptw = NULL,
					*h2p_lw_wrap_address_chrono = NULL, *h2p_lw_wrap_address_modulation = NULL, *h2p_lw_address_wrap_rd_db = NULL,
					*h2p_lw_wrap_address_chrono2 = NULL, *h2p_lw_wrap_address_adc = NULL, *h2p_lw_wrap_address_pulsePgr = NULL,
					*h2p_lw_wrap_address_base = NULL;

// Data wrapper module registers pointers 32bit type take this in account for the right pointer arithmetic
volatile uint32_t *h2p_lw_wrap_data_init = NULL, *h2p_lw_wrap_data_ftw = NULL, *h2p_lw_wrap_data_ptw = NULL,
					*h2p_lw_wrap_data_chrono = NULL, *h2p_lw_wrap_data_modulation = NULL, *h2p_lw_wrap_data_db = NULL,
					*h2p_lw_wrap_data_chrono2 = NULL, *h2p_lw_wrap_data_adc = NULL, *h2p_lw_wrap_data_pulsePgr = NULL,
					*h2p_lw_wrap_data_rd_init = NULL, *h2p_lw_wrap_data_rd_ftw = NULL, *h2p_lw_wrap_data_rd_ptw = NULL,
					*h2p_lw_wrap_data_rd_chrono = NULL,	*h2p_lw_wrap_data_rd_modulation = NULL, *h2p_lw_wrap_data_rd_db = NULL,
					*h2p_lw_wrap_data_rd_chrono2 = NULL, *h2p_lw_wrap_data_rd_adc = NULL, *h2p_lw_wrap_data_rd_pulsePgr = NULL,
					*h2p_lw_wrap_data_base = NULL;

void *virtual_base;

int fd; // fd -> File descriptor, its an identifier for the file, low level and POSIX (Unix-like systems)


int fd_open ()
{

	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) { //
			printf( "ERROR: could not open \"/dev/mem\"...\n" );
			return( 1 );
	}
	else
		{return 0;
		}
}

int  mmap_virtual ()
{
	//Maps physical HPS address map in to a virtual space
	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );

	if( virtual_base == MAP_FAILED ) { // on error MAP_FAILED = (void *) -1 Is returned
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return(1);
	}
	else
		{return 0;
		}
}

int munmap_virtual(){
	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd ); //closing the file descriptor does not unmap the region.
		return( 1 );
	}
	else{
		return 0;}
}

void fd_close(){
	close( fd ); //closing the file descriptor does not unmap the region.
}

// Virtual mem mapped base address
void wrapper_mmap()
{
// Control
	h2p_lw_wrap_ctrl_base 		= virtual_base + (( unsigned long  )( ALT_LWFPGASLVS_OFST+ WRAPPER_CTRL_BASE) &( unsigned long)( HW_REGS_MASK ) );
	// Write Ctrl Wrapper Reg
	h2p_lw_wrap_ctrl_init		= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_INIT_REG;
	h2p_lw_wrap_ctrl_ftw		= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_FTW_REG;
	h2p_lw_wrap_ctrl_ptw		= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_PTW_REG;
	h2p_lw_wrap_ctrl_chrono		= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_CHRONO_REG;
	h2p_lw_wrap_ctrl_modulation	= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_MODULATION_REG;
	h2p_lw_wrap_ctrl_wr_db		= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_DB_REG;
	h2p_lw_wrap_ctrl_outmux		= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_OUTMUX_REG;
	h2p_lw_wrap_ctrl_chrono2 	= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_CHRONO2_REG;
	h2p_lw_wrap_ctrl_adc 		= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_ADC_REG;
	h2p_lw_wrap_ctrl_pulsePgr 	= h2p_lw_wrap_ctrl_base + WRAPPER_WR_CTRL_PULSEPGR_REG;
	// Read Ctrl Wrapper Reg
	h2p_lw_wrap_ctrl_rd_fsmflags= h2p_lw_wrap_ctrl_base + WRAPPER_RD_CTRL_FSM_FLAGS_REG;
	h2p_lw_wrap_ctrl_rd_db		= h2p_lw_wrap_ctrl_base + WRAPPER_RD_CTRL_DB_REG;

// Address
	h2p_lw_wrap_address_base 	= virtual_base + (( unsigned long  )( ALT_LWFPGASLVS_OFST+ WRAPPER_ADDRESS_BASE) &( unsigned long)( HW_REGS_MASK ) );
	// Write Address Wrapper Reg
	h2p_lw_wrap_address_init		= h2p_lw_wrap_address_base + WRAPPER_WR_ADDRESS_INIT_REG;
	h2p_lw_wrap_address_ftw			= h2p_lw_wrap_address_base + WRAPPER_WR_ADDRESS_FTW_REG;
	h2p_lw_wrap_address_ptw			= h2p_lw_wrap_address_base + WRAPPER_WR_ADDRESS_PTW_REG;
	h2p_lw_wrap_address_chrono		= h2p_lw_wrap_address_base + WRAPPER_WR_ADDRESS_CHRONO_REG;
	h2p_lw_wrap_address_modulation	= h2p_lw_wrap_address_base + WRAPPER_WR_ADDRESS_MODULATION_REG;
	h2p_lw_wrap_address_chrono2 	= h2p_lw_wrap_address_base + WRAPPER_WR_ADDRESS_CHRONO2_REG;
	h2p_lw_wrap_address_adc 		= h2p_lw_wrap_address_base + WRAPPER_WR_ADDRESS_ADC_REG;
	h2p_lw_wrap_address_pulsePgr 	= h2p_lw_wrap_address_base + WRAPPER_WR_ADDRESS_PULSEPGR_REG;
	// Read Address Wrapper Reg
	h2p_lw_address_wrap_rd_db		= h2p_lw_wrap_address_base + WRAPPER_RD_ADDRESS_DB;

// Data
	h2p_lw_wrap_data_base 		= virtual_base + (( unsigned long  )( ALT_LWFPGASLVS_OFST+ WRAPPER_DATA_BASE) &( unsigned long)( HW_REGS_MASK ));
	// Write Data Wrapper Reg
	h2p_lw_wrap_data_init			= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_INIT_REG;
	h2p_lw_wrap_data_ftw			= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_FTW_REG;
	h2p_lw_wrap_data_ptw			= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_PTW_REG;
	h2p_lw_wrap_data_chrono			= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_CHRONO_REG;
	h2p_lw_wrap_data_modulation		= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_MODULATION_REG;
	h2p_lw_wrap_data_db				= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_DB_REG;
	h2p_lw_wrap_data_chrono2 		= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_CHRONO2_REG;
	h2p_lw_wrap_data_adc 			= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_ADC_REG;
	h2p_lw_wrap_data_pulsePgr 		= h2p_lw_wrap_data_base + WRAPPER_WR_DATA_PULSEPGR_REG;

	// Read Data Wrapper Reg
	h2p_lw_wrap_data_rd_init		= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_INIT_REG;
	h2p_lw_wrap_data_rd_ftw			= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_FTW_REG;
	h2p_lw_wrap_data_rd_ptw			= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_PTW_REG;
	h2p_lw_wrap_data_rd_chrono		= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_CHRONO_REG;
	h2p_lw_wrap_data_rd_modulation	= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_MODULATION_REG;
	h2p_lw_wrap_data_rd_db			= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_DB_REG;
	h2p_lw_wrap_data_rd_chrono2 	= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_CHRONO2_REG;
	h2p_lw_wrap_data_rd_adc 		= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_ADC_REG;
	h2p_lw_wrap_data_rd_pulsePgr 	= h2p_lw_wrap_data_base + WRAPPER_RD_DATA_PULSEPGR_REG;

	/*
	printf("\n -------------------------------------------\n");
	printf("\n CHECK POINTER ARITHM");
	printf("\n 	virtual_base	    			= %X",	(unsigned int)virtual_base);
	printf("\n ");
	printf("\n 	h2p_lw_wrap_ctrl_init    		= %X",	(unsigned int)h2p_lw_wrap_ctrl_init);
	printf("\n 	h2p_lw_wrap_address_init		= %X",	(unsigned int)h2p_lw_wrap_address_init);
	printf("\n 	h2p_lw_wrap_data_init    		= %X",	(unsigned int)h2p_lw_wrap_data_init);
	printf("\n ");
	printf("\n 	h2p_lw_wrap_ctrl_ftw    		= %X",	(unsigned int)h2p_lw_wrap_ctrl_ftw);
	printf("\n 	h2p_lw_wrap_address_ftw 		= %X",	(unsigned int)h2p_lw_wrap_address_ftw);
	printf("\n 	h2p_lw_wrap_data_ftw    		= %X",	(unsigned int)h2p_lw_wrap_data_ftw);
	printf("\n ");
	printf("\n 	h2p_lw_wrap_ctrl_ptw    		= %X",	(unsigned int)h2p_lw_wrap_ctrl_ptw);
	printf("\n 	h2p_lw_wrap_address_ptw 		= %X",	(unsigned int)h2p_lw_wrap_address_ptw);
	printf("\n 	h2p_lw_wrap_data_ptw    		= %X",	(unsigned int)h2p_lw_wrap_data_ptw);
	printf("\n ");
	printf("\n 	h2p_lw_wrap_ctrl_chrono    		= %X",	(unsigned int)h2p_lw_wrap_ctrl_chrono);
	printf("\n 	h2p_lw_wrap_address_chrono 		= %X",	(unsigned int)h2p_lw_wrap_address_chrono);
	printf("\n 	h2p_lw_wrap_data_chrono    		= %X",	(unsigned int)h2p_lw_wrap_data_chrono);
	printf("\n ");
	printf("\n 	h2p_lw_wrap_ctrl_modulation 	= %X",	(unsigned int)h2p_lw_wrap_ctrl_modulation);
	printf("\n 	h2p_lw_wrap_address_modulation 	= %X",	(unsigned int)h2p_lw_wrap_address_modulation);
	printf("\n 	h2p_lw_wrap_data_modulation    	= %X",	(unsigned int)h2p_lw_wrap_data_modulation);
	printf("\n -------------------------------------------\n");
	 */

	/*-----------------------------------------------------   ---------------------------------------------------------------------------------*/
}
