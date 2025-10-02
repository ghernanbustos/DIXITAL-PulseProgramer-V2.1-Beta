/*
 * 	File: main.c
 *
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

// C POSIX library
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> //POSIX (Unix-like systems)
#include <fcntl.h>	//POSIX (Unix-like systems)
#include <time.h>
//Intel SoC FPGA Altera Hardware Libs (HWLibs)
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h" 		// Contains the HPS component's full Register Map.
#include "socal/alt_gpio.h"	// only to manage GPIO micro controller ports
//
#include "../include/hps_0_wrapper.h"
#include "../include/ad9854.h"


int main(int argc, char **argv)
{
	// Menu variables
	int a, i,n;
	uint32_t choice, op, freq, phase, mempos = 0,data_pgr;
	float 		 time_pulse;
    //unsigned int dataTestUser;

	// Parser variables to manipulate file
    char filename[100];        // To store user input
    char fullpath[120];        // Full name with ".txt"



    /*-----------------------------------------------------------------*/
	printf( "\n Initialization Unix-Like Virtual Memory Map Routine \n");
	((fd_open () == 0) ? (printf("	File open Ok\n")) : (printf("	File open Fail\n")));
	((mmap_virtual () == 0) ? (printf("\n	Virtual Mem1 Ok\n")) : (printf("\n	Virtual Mem1 Fail\n")) );
	wrapper_mmap(); // Set virtual memory address for wrapper registers
    /*-----------------------------------------------------------------*/
	printf( "  \n");
	printf( "  ********************************************************************************\n");
	printf( "  ********************************************************************************\n");
	printf( "  				DIXITAL Project - UNC FAMAF \n");
	printf( "  			DDS 9854 HPS-FPGA Driver Prototype 2023-2024\n");
	printf( "  ********************************************************************************\n");
	printf( "  ********************************************************************************\n");

/*
	printf(" \n\n Menu:"
			"\n Individual and Manual Buffer accessing"
			"\n 1- Manual Access to INIT MODULE "
			"\n 2- Manual Access to FTW MODULE  "
			"\n 3- Manual Access to PTW MODULE  "
			"\n 4- Manual Access to Chrono1 Module "
			"\n 5- Manual Access to Chrono2 Module "
			"\n 6- Manual Access to Sinc Modulation 	 "
			"\n 7- Manual Access to PGR "
			"\n 8- --------------------- "
			"\n 9- --------------------- "
			"\n 10- -------------------- "
			"\n 11- Reads .txt file and loads Program Sequence"
			"\n 12- Start Pulse Program Sequence"
			"\n\n Set 0 to exit Menu"
			"\n"
			"\n CAUTION USING OP=0 IN MANUAL ACCESS, It will rewrite buffer mem position with predefined data in main.c swtich routines"
			"\n LET parser use this operation with INIT MODULE");
*/

	a = 1;
	while(a == 1)
		{

		printf(" \n\n Menu:"
				"\n Individual and Manual Buffer accessing"
				"\n 1- Manual Access to INIT MODULE "
				"\n 2- Manual Access to FTW MODULE  "
				"\n 3- Manual Access to PTW MODULE  "
				"\n 4- Manual Access to Chrono1 Module "
				"\n 5- Manual Access to Chrono2 Module "
				"\n 6- Manual Access to Sinc Modulation 	 "
				"\n 7- Manual Access to PGR "
				"\n 8- --------------------- "
				"\n 9- --------------------- "
				"\n 10- -------------------- "
				"\n 11- Reads .txt file and loads Program Sequence"
				"\n 12- Start Pulse Program Sequence"
				"\n\n Set 0 to exit Menu"
				"\n"
				"\n CAUTION USING OP=0 IN MANUAL ACCESS, It will rewrite buffer mem position with predefined data in main.c swtich routines"
				"\n LET parser use this operation with INIT MODULE");

			printf(" \n\n===================================== ");
			printf(" \n\n Option --> ");
			scanf("%u", &choice);
			printf("\n");
			switch (choice) {
				case 1:
					// Pre-defined initialization - For Custom create another function with console input data access.
					printf("\n Init Module Selected ");
					printf("\n Check predefined data when using op = 0 ");
					printf("\n Select Operation: \n\t 0 -> Write Buffer with predefined data \n\t 1 -> Read Buffer \n\t 2 ->Set data to DDS ");
					printf("\n Op --> ");
					scanf("%d", &op);
					printf("\n MemPos --> ");
					scanf("%d", &mempos);
					// each field set config reg bits value.
				    ad9854_init( 0x00,
				                REFCLK_MULT_15 | REG2_CTRL_BIT_PLLRANGE,
								OM_SINGLE_TONE,
								REG4_CTRL_BIT_OSK_EN | REG4_CTRL_BIT_BYPASS_INV,
								op, mempos);
				    //ad9854_init( 0x00, 0x00, 0x00, 0x00, op, mempos);
					break;

				case 2:
					printf("\n FTW Module Selected - Introduce two parameters");
					printf("\n Select Operation: \n\t 0 -> Write Buffer \n\t 1 -> Read Buffer \n\t 2 ->Set written data to DDS ");
					printf("\n op -->  ");
					scanf("%d", &op);
					printf("\n Pos --> ");
					scanf("%d", &mempos);
					printf("\n Freq --> ");
					scanf("%d", &freq);
					ad9854_ftw_set( freq,0,op,mempos); // Calc Ftw and writes Buffer
					break;

				case 3:
					printf("\n PTW Module Selected - Introduce one parameter");
					printf("\n Select Operation: \n\t 0 -> Write Buffer \n\t 1 -> Read Buffer \n\t 2 ->Set written data to DDS ");
					printf("\n op --> ");
					scanf("%u", &op);
					printf("\n Pos --> ");
					scanf("%u", &mempos);
					printf("\n Phase --> ");
					scanf("%d", &phase);
					ad9854_phase_set( phase, op, mempos);
					break;

				case 4: //CHRONO 1 - MODULE
					printf("\n Chrono1 module Manual PRELOAD DATA word \n");
					printf("\n Select Operation: \n\t 0 -> Write Buffer \n\t 1 -> Read Buffer \n\t 2 ->Set written data to DDS \n\t 3 ->Set written data to DDS with NCO enable ");
					printf("\n op --> ");
					scanf("%u", &op);
					printf("\n Pos --> ");
					scanf("%u", &mempos);
					printf("\n PulseWidth --> ");
					scanf("%f", &time_pulse);
					chrono_1_32b( time_pulse,  op,  mempos ); // Load and check data in buffer
					break;

				case 5: //CHRONO 2 - MODULE
					printf("\n Chrono2 module Manual PRELOAD DATA word \n");
					printf(" op --> ");
					scanf("%u", &op);
					printf(" Pos --> ");
					scanf("%u", &mempos);
					printf("\n Time --> ");
					scanf("%f", &time_pulse);
					chrono_2_32b( time_pulse,  op,  mempos ); // Load and check data in buffer
					break;
				case 6:
					printf("\n Sinc Pulse Modulation Pulse Width\n");
					printf("\n Select Operation: \n\t 0 -> Write Buffer \n\t 1 -> Read Buffer \n\t 2 ->Set written data to DDS \n\t 3 ->HPS rst Modulation\n");
					printf("\n op --> ");
					scanf("%u", &op);
					printf("\n Pos --> ");
					scanf("%u", &mempos);
					printf("\n Sinc Width --> ");
					scanf("%f", &time_pulse);
					sinc_modulation( time_pulse, op,  mempos  );
					break;

				case 7:
					printf("PGR Manual accessing");
					printf("\n Select Operation: \n\t 0 -> Write Buffer \n\t 1 -> Read Buffer \n\t 2 ->Set written data to DDS \n\t 3 -> Erase buffer \n");
					printf("\n op --> ");
					scanf("%u", &op);
					printf("\n Pos --> ");
					scanf("%d", &mempos);
					printf("\n PGR data --> ");
					scanf("%u", &data_pgr);
					pulse_pgr( data_pgr,  op , mempos );// Loads program sequence buffer.
					break;

				case 8:
					printf("Finish the program and show part of the Virtual memory space\n");
					a = 0; // Break While loop
					break;

				case 9:
					/*
					printf("Start chrono 1 timer loop \n");
					printf("\n Introduce RAM pos --> ");
					scanf("%u", &mempos);

					for(i=0;i<=100000;i++){
						chrono_1_32b( 0 , 2,  mempos ); // execute mempos
						chrono_2_32b( 0,  2,  mempos );
					}
					*/
					break;

				case 10:
					/*
					printf("\n Mem Selected [%u] --> ", mempos);
					printf("\n Mem Selected [%d] --> ", mempos);
					//					printf("Start chorno 2 timer loop \n");
//					printf("\n Introduce RAM pos --> ");
//					scanf("%d", &mempos);
//
//					for(i=0;i<=10000;i++){
//						chrono_2_32b( time_pulse,  2,  mempos ); // Load and check data in buffer
//						for(n=0;n<=100;n++);
//					}
					*/
					break;

				case 11:
				    // File name.
				    printf("Enter file name (without extension): ");
				    scanf("%99s", filename);   // Read up to 99 characters (safe)
				    // Append ".txt" to the name
				    snprintf(fullpath, sizeof(fullpath), "%s.txt", filename);
				    parse_file(fullpath);

					break;

				case 12:
					printf("Init PGR sequence");
//					for(i = 0 ; i <= 1000; i++){
						pulse_pgr( 0,  2 , 0 );
//					}
					break;

				default:
					printf("Out Switch.\n");
					a = 0;
					break;
			}

		}

	munmap_virtual();
	fd_close(); // fd = file descriptor


	return 0;
}
