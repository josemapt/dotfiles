#include <time.h>

#include "../util.h"


void
date(char *str)
{
        time_t t = time(NULL);
        struct tm tm = *localtime(&t);

        strftime(str, BLOCKLENGTH, COL2 "  %H:%M", &tm);
}

void
date_c() {
        cspawn((char *[]){ "/usr/local/bin/st", "-ig", "20x8-0+0", "watch", "-t", "cal" , NULL });
}