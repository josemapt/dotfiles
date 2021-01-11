#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <err.h>

#include "util.h"

char *
get_battery(char* path) {
	FILE *fp;
    int capacity;
	char status[12];
    char* prefix = "E";

	char* icons[11] = {"", "", "", "", "", "", "", "", "", "", ""};
	char* char_icons[11] = {"", "", "", "", "", "", "", "", "", "", ""};

    if ((fp = fopen("/sys/class/power_supply/BAT0/capacity","r")) == NULL){
        warnx("cannot get battery capacity");
    }

    fscanf(fp,"%d", &capacity);
    fclose(fp);

	if ((fp = fopen("/sys/class/power_supply/BAT0/status","r")) == NULL){
        warnx("cannot get battery status");
    }

	fscanf(fp,"%s", status);
    fclose(fp);

	if (status[0] == 'D'){
		prefix = icons[(capacity /10)];
	} else{
		prefix = char_icons[(capacity /10)];
	}

	return smprintf("%s %d%%", prefix, capacity);
}