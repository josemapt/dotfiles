#include <stdio.h>

#include "../util.h"

#define ICONn                           " "
#define ICONc                           " "

#define WARNCPUTEMP                     60000

#define CPUTEMPFILE                     "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp2_input"

void
cpu_temp(char *str)
{
        int temp;

        if (!readint(CPUTEMPFILE, &temp)) {
                *str = '\0';
                return;
        }
        if (temp < WARNCPUTEMP)
                snprintf(str, BLOCKLENGTH, COL4 ICONn "%d°C", temp / 1000);
        else
                snprintf(str, BLOCKLENGTH, COL4 ICONc "%d°C", temp / 1000);
}

void
cpu_temp_c() {
        cspawn((char *[]){ "/usr/local/bin/st", "top", "-d", "1" , NULL });
}