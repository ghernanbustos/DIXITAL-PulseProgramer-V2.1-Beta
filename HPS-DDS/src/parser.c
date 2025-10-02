/*
 * 	File: parser.c
 *
 *  Description: 	Parse function use to read a programSeq.txt file.
 *  The program file has a defined format. The parameters are Fetched
 *  and loaded in FPGA buffers memories.
 *  The program file consist in a parameter preload and then
 *  the sequential software loaded in program buffer which has the information
 *  to access at different buffers.
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
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include "../include/ad9854.h"
#include "../include/parser.h"

/**********************************************************************
*
* Function: parser.c
*
* Description: Initialize DDS.
*
* Notes:
*   This function open txt file, reads the informatio and loads buffers parameters in FPGA.
*   	All buffers are loaded sequentially, the last information are the program seq.
* Returns: 0 if file was open, 1 if it fails.
* Params:
* 	fileName = file name string to be open and processed.
**********************************************************************/

int parse_file( const char *fileName) {

    char line[150]; // to store file line at each while loop
    uint32_t initModFlag = 0, ftwModFlag = 0,ptwModFlag = 0,
            chrono1ModFlag = 0, chrono2ModFlag = 0, 
            sincWindowModFlag = 0, pgrModFlag = 0;
    uint32_t initModuleParsed,ftwModuleParsed,ptwModuleParsed, chrono1ModuleParsed,
            chrono2ModuleParsed,windowSincParsed,pgrParsed;
    uint32_t pwdConfigDDS, clkConfigDDS, modeConfigDDS, oskConfigDDS,
            ftwWord,ptwWord,pgrWord;
    uint32_t memposVar,operationVar; // generic for all modules
    float    chrono1Word,chrono2Word,sincWindowWord;

    // file pointer
    FILE *file = fopen(fileName, "r");
    if (!file) {
        printf("Error, file not found\n");
        return 1;
    }

    printf("\n ========================================================\n");
    printf("\n ========================================================\n");
    printf("\n PARSER init program file reading and pre loading data   \n");
    printf("\n ========================================================\n");
    printf("\n ========================================================\n");

    while (fgets(line, sizeof(line), file)) {
        // ----------- INIT MODULE -----------------
    	// -----------------------------------------
        if (!initModFlag) { //  (!expr), (!) Not operator, When expr = 1 => (FALSE),When expr = 0 => (TRUE)
            if (strstr(line, "init:")) {
                initModFlag = 1; // flag
            }
            continue;
        }
        initModuleParsed = sscanf( // Parse Data.
            line,
            "mempos=[%u],operation=[%u],pwd_dds=[0x%2X],clk_dds=[0x%X],mode_dds=[0x%X],osk_dds=[0x%X];",
            &memposVar,
            &operationVar,
            &pwdConfigDDS,
            &clkConfigDDS,
            &modeConfigDDS,
            &oskConfigDDS
        );

        if (initModuleParsed == 6) { // Console output to Check Parsed Data
            printf("\n -------------------------------------------");
            printf("\n INIT BLOCK");
            printf("\nmempos=%u, ", memposVar);
            printf("operation=%u \n", operationVar);
            printf("pwd_dds=0x%02X = %u, ", pwdConfigDDS,pwdConfigDDS);
            printf("clk_dds=0x%02X = %u, ", clkConfigDDS,clkConfigDDS);
            printf("mode_dds=0x%02X = %u, ", modeConfigDDS, modeConfigDDS);
            printf("osk_dds=0x%02X = %u\n", oskConfigDDS, oskConfigDDS);
            printf("\n");

        // Call driver function to preload data in FPGA buffer.
        ad9854_init((uint16_t) pwdConfigDDS,(uint16_t) clkConfigDDS,(uint16_t) modeConfigDDS,
        		(uint16_t) oskConfigDDS, (uint16_t) operationVar,(uint8_t) memposVar); // Writes init data config in DDS

//        initModuleParsed = 0;
        }

        // --------------- FTW----------------------
    	// -----------------------------------------

        if (!ftwModFlag) {
            if (strstr(line, "ftw:")) {
                ftwModFlag = 1; // flag
            }
            continue;
        }
        ftwModuleParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],freq=[%u];",
            &memposVar,
            &operationVar,
            &ftwWord
        );

        if (ftwModuleParsed == 3) { // Check Parsed Data
            printf("\n -------------------------------------------");
            printf("\n FTW BLOCK:");
            printf("\n mempos=%d, op=%u, ftw_dds=0x%03X , %u \n", memposVar, operationVar,ftwWord, ftwWord);
            //printf("operation=%u \n", operationVar);
            //printf("ftw_dds=0x%03X , %u \n", ftwWord, ftwWord);
            //printf("\n");

        // Accuracy cal fixed in '0' option := 64bits operation. If want to change it, modify function definition .c file
        ad9854_ftw_set((uint32_t) ftwWord ,  (uint8_t) 0 ,
        		(uint8_t) operationVar, (uint8_t) memposVar );// Writes ftw word in DDS
        }
        // --------------- PTW ---------------------
    	// -----------------------------------------
        if (!ptwModFlag) {
            if (strstr(line, "ptw:")) {
                ptwModFlag = 1; // flag
            }
            continue;
        }
        ptwModuleParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],phase=[%u];",
            &memposVar,
            &operationVar,
            &ptwWord
        );

        if (ptwModuleParsed == 3) { // Check Parsed Data
            printf("\n -------------------------------------------");
            printf("\n PTW BLOCK: ");
            printf("\nmempos=%u, op=%u, ptwWord = 0x%03X , %u \n", memposVar,operationVar, ptwWord,ptwWord);
            //printf("operation=%u\n", operationVar);
            //printf("ptwWord = 0x%03X , %u \n", ptwWord,ptwWord);
            //printf("\n");


        ad9854_phase_set( (uint32_t) ptwWord ,  (uint8_t) operationVar, (uint8_t) memposVar); // Writes phase word in DDS
        }

        // -------------CHRONO1----------------
    	// -----------------------------------------
        if (!chrono1ModFlag) {
            if (strstr(line, "chrono1:")) {
                chrono1ModFlag = 1; // flag
            }
            continue;
        }
        chrono1ModuleParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],chron1_window=[%f];",
            &memposVar,
            &operationVar,
            &chrono1Word
        );

        if (chrono1ModuleParsed == 3) { // Check Parsed Data
            printf("\n -------------------------------------------");
            printf("\n Chrono1 BLOCK");
            printf("\nmempos=%u,op=%u, chrono1Word = %.9f\n", memposVar,operationVar,chrono1Word);
            //printf("operation=%u\n", operationVar);
            //printf("chrono1Word = %.9f \n", chrono1Word);
            //printf("\n");

        chrono_1_32b( (float) chrono1Word,   operationVar,  memposVar );
        }

        // ------------- CHRONO2 -------------------
    	// -----------------------------------------

        if (!chrono2ModFlag) {
            if (strstr(line, "chrono2:")) {
                chrono2ModFlag = 1; // flag
            }
            continue;
        }
        chrono2ModuleParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],chron2_window=[%f];",
            &memposVar,
            &operationVar,
            &chrono2Word
        );

        if (chrono2ModuleParsed == 3) { // Check Parsed Data
            printf("\n -------------------------------------------");
            printf("\n Chrono2 BLOCK");
            printf("\nmempos=%u,op=%u,chrono2Word = %.9f \n", memposVar,operationVar,chrono2Word);
            //printf("operation=%u\n", operationVar);
            //printf("chrono2Word = %.9f\n",chrono2Word);
            //printf("\n");


        chrono_2_32b( (float) chrono2Word, operationVar, memposVar );
        }
        // ----------- SINCWINDOW ------------------
    	// -----------------------------------------

        if (!sincWindowModFlag) {
            if (strstr(line, "sincWindow:")) {
                sincWindowModFlag = 1; // flag
            }
            continue;
        }
        windowSincParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],sincWindow=[%f];",
            &memposVar,
            &operationVar,
            &sincWindowWord
        );

        if (windowSincParsed == 3) { // Check Parsed Data
            printf("\n -------------------------------------------");
            printf("\n sincWindow BLOCK");
            printf("\nmempos=%u,op=%u, SincWindow = %.6f \n", memposVar,operationVar,sincWindowWord);
            //printf("operation=%u\n", operationVar);
           // printf("SincWindow = %.6f\n", sincWindowWord);
           // printf("\n");

        sinc_modulation( (float) sincWindowWord,  (uint8_t) operationVar, (uint8_t) memposVar ); // Set Sinc modulation pulse witdh
        }

        // ----------------- PGR -------------------
        // -----------------------------------------

        if (!pgrModFlag) {
            if (strstr(line, "program:")) {
                pgrModFlag = 1; // flag
            }
            continue;
        }
        pgrParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],pgr_word=[%X];",
            &memposVar,
            &operationVar,
            &pgrWord
        );

        if (pgrParsed == 3) { // Check Parsed Data
            printf("\n -------------------------------------------");
            printf("\n PGR BLOCK");
            printf("\nmempos=%u, op=%u, pgrWord =0x%08X, %u \n", memposVar,operationVar, pgrWord, pgrWord);
            //printf("operation=%u\n", operationVar);
            //printf("pgrWord =0x%08X, %u \n", pgrWord, pgrWord);
            //printf("\n");

            pulse_pgr( pgrWord,  operationVar , memposVar );// Loads program sequence buffer.
        }
    }

    if (fclose(file) != 0) {
        perror("Error closing file");
        return 1;
    }
    return 0;
}
