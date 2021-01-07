
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <stdint.h>
#include <unistd.h>
#include <time.h>


int main() {
    char quality[2] = "00";
    char* quality_icon = "";

    FILE *fd;                           // File pointer
    static const long max_len = 179+ 1;  // define the max length of the line to read
    char buff[max_len + 1];             // define the buffer and allocate the length

    if ((fd = fopen("/proc/net/wireless", "r")) != NULL)  {      // open file. I omit error checks

        fseek(fd, -max_len, SEEK_END);            // set pointer to the end of file minus the length you need. Presumably there can be more than one new line caracter
        fread(buff, max_len-1, 1, fd);            // read the contents of the file starting from where fseek() positioned us
        fclose(fd);                               // close the file

        buff[max_len-1] = '\0';                   // close the string
        char *last_newline = strrchr(buff, '\n'); // find last occurrence of newlinw 
        char *last_line = last_newline+1;         // jump to it

        // Get quality from last_line (2 last character)
        for (int i = 0; last_line[i] != '\0'; ++i){
            if ((i = 15))
                quality[0] = last_line[i];
            if ((i = 16))
                quality[1] = last_line[i];
        }

    }

    switch(quality[0]){
        case '7':
        case '6':
            quality_icon = "";
            break;
        case '5':
        case '4':
            quality_icon = "";
            break;
        case '3':
        case '2':
            quality_icon = "";
            break;
        case '1':
        case '0':
            quality_icon = "";
            break;
    }

    printf("%s %s", quality_icon, quality);

    return 0;
}