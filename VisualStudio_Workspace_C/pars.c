/*
    To compile and run a C program using gcc, follow these steps:

    1. Write Your C Code
    Save your C code in a file, e.g., program.c.

    2. Compile the Code
    Use the gcc command to compile the code:

    Copy the code
    gcc -o program program.c
    -o program: Specifies the output file name (in this case, program).
    program.c: The source file to compile.
    If there are no errors, this will create an executable file named program.

    3. Run the Executable
    Execute the compiled program:

    Copy the code
    ./program
*/

#include <stdio.h>
#include <stdint.h>
#include <string.h>

int main() {
    // to manipulate file
    char filename[100];        // To store user input
    char fullpath[120];        // Full name with ".txt"
    //
    char line[150]; // to store file line at each while loop
    int initModFlag = 0, ftwModFlag = 0,ptwModFlag = 0,
            chrono1ModFlag = 0, chrono2ModFlag = 0, 
            sincWindowModFlag = 0, pgrModFlag = 0;
    int initModuleParsed,ftwModuleParsed,ptwModuleParsed, chrono1ModuleParsed,
            chrono2ModuleParsed,windowSincParsed,pgrParsed;
    uint32_t pwdConfigDDS, clkConfigDDS, modeConfigDDS, oskConfigDDS,
            ftwWord,ptwWord,pgrWord;
    uint32_t memposVar,operationVar;
    float    chrono1Word,chrono2Word,sincWindowWord;

    // File name.
    printf("Enter file name (without extension): ");
    scanf("%99s", filename);   // Read up to 99 characters (safe)
    // Append ".txt" to the name
    snprintf(fullpath, sizeof(fullpath), "%s.txt", filename);

    // FILE *file = fopen("C:/Users/guill/OneDrive/Escritorio/VisualStudio_Workspace_C/programSeq.txt", "r");
    FILE *file = fopen(fullpath, "r");
    if (!file) {
        printf("Error opening file!\n");
        return 1;
    }

// printf("Data = 0x%3X ---- %u\n, testDataOutput,testDataOutput");

    while (fgets(line, sizeof(line), file)) {
        // ----------- INIT MODULE -----------------                                 
        if (!initModFlag) {
            if (strstr(line, "init:")) {
                initModFlag = 1; // flag
            }
            continue;
        }
        initModuleParsed = sscanf( // Parse Data.
            line,
            "mempos=[%u],operation=[%u],pwd_dds=[0x%X],clk_dds=[0x%X],mode_dds=[0x%X],osk_dds=[0x%X];",
            &memposVar,
            &operationVar,
            &pwdConfigDDS,
            &clkConfigDDS,
            &modeConfigDDS,
            &oskConfigDDS
        );
        if (initModuleParsed == 6) { // Check Parsed Data
            printf("mempos=%u \n", memposVar);
            printf("operation=%u \n", operationVar);
            printf("pwd_dds=0x%02X = %u \n", pwdConfigDDS,pwdConfigDDS);
            printf("clk_dds=0x%02X = %u\n", clkConfigDDS,clkConfigDDS);
            printf("mode_dds=0x%02X = %u\n", modeConfigDDS, modeConfigDDS);
            printf("osk_dds=0x%02X = %u\n", oskConfigDDS, oskConfigDDS);
            printf("----------------------\n");
        }








        // -------------FTW----------------------
        if (!ftwModFlag) {
            if (strstr(line, "ftw:")) {
                ftwModFlag = 1; // flag
            }
            continue;
        }
        ftwModuleParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],ftw_word=[%u];",
            &memposVar,
            &operationVar,
            &ftwWord
        );
        if (ftwModuleParsed == 3) { // Check Parsed Data
            printf("mempos=%d\n", memposVar);
            printf("operation=%u\n", operationVar);
            printf("ftw_dds=0x%03X , %u \n", ftwWord, ftwWord);
            printf("----------------------\n");
        }
        // --------------PTW--------------------
        if (!ptwModFlag) {
            if (strstr(line, "ptw:")) {
                ptwModFlag = 1; // flag
            }
            continue;
        }
        ptwModuleParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],ptw_word=[%u];",
            &memposVar,
            &operationVar,
            &ptwWord
        );
        if (ptwModuleParsed == 3) { // Check Parsed Data
            printf("mempos=%u\n", memposVar);
            printf("operation=%u\n", operationVar);
            printf("ptwWord = 0x%03X , %u \n", ptwWord,ptwWord);
            printf("----------------------\n");
        }
        // -------------CHRONO1----------------
        if (!chrono1ModFlag) {
            if (strstr(line, "chrono1:")) {
                chrono1ModFlag = 1; // flag
            }
            continue;
        }
        chrono1ModuleParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],chron_word=[%f];",
            &memposVar,
            &operationVar,
            &chrono1Word
        );
        if (chrono1ModuleParsed == 3) { // Check Parsed Data
            printf("mempos=%u\n", memposVar);
            printf("operation=%u\n", operationVar);
            printf("chrono1Word = %.6f \n", chrono1Word);
            printf("----------------------\n");
        }
        // -----------CHRONO2 -------------------
        if (!chrono2ModFlag) {
            if (strstr(line, "chrono2:")) {
                chrono2ModFlag = 1; // flag
            }
            continue;
        }
        chrono2ModuleParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],chron_word=[%f];",
            &memposVar,
            &operationVar,
            &chrono2Word
        );
        if (chrono2ModuleParsed == 3) { // Check Parsed Data
            printf("mempos=%u\n", memposVar);
            printf("operation=%u\n", operationVar);
            printf("chrono2Word = %.6f\n",chrono2Word);
            printf("----------------------\n");
        }

            // -----------SINCWINDOW -------------------
        if (!sincWindowModFlag) {
            if (strstr(line, "sincWindow:")) {
                sincWindowModFlag = 1; // flag
            }
            continue;
        }
        windowSincParsed = sscanf(
            line,
            "mempos=[%u],operation=[%u],sincWindow_word=[%f];",
            &memposVar,
            &operationVar,
            &sincWindowWord
        );
        if (windowSincParsed == 3) { // Check Parsed Data
            printf("mempos=%u\n", memposVar);
            printf("operation=%u\n", operationVar);
            printf("SincWindow = %.6f\n", sincWindowWord);
            printf("----------------------\n");
        }
        // -----------PGR -------------------
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
            printf("mempos=%u\n", memposVar);
            printf("operation=%u\n", operationVar);
            printf("pgrWord =0x%08X, %lu \n", pgrWord, pgrWord);
            printf("----------------------\n");
        }
    }

    fclose(file);
    return 0;
}
