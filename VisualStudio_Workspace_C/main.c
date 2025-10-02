/*
-----------------------------------------
-----------------------------------------
-----------------------------------------
*/

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "parser.h"

int main() {
    // to manipulate file
    char filename[100];        // To store user input
    char fullpath[120];        // Full name with ".txt"

    // File name.
    printf("Enter file name (without extension): ");
    scanf("%99s", filename);   // Read up to 99 characters (safe)
    // Append ".txt" to the name
    snprintf(fullpath, sizeof(fullpath), "%s.txt", filename);
    
    parse_file(fullpath);

    return 0;
}