#include <stdio.h>

#include "../util.h"

void
powerbutton(char *str){
    snprintf(str, BLOCKLENGTH, COL1 " ");
}

void
powerbutton_c(){
    cspawn((char *[]){ "/usr/bin/shutdown", "now" , NULL });
}