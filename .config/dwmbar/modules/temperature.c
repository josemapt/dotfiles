#include <stdio.h>
#include <stdlib.h>

#include "util.h"

int get_temp(char* sensor) {
	int temperature;
	FILE *fp;

	if ((fp = fopen(sensor, "r")) != NULL){
		fscanf(fp, "%d", &temperature);
		return temperature / 1000;
	} else {
		return -1;
	}

	fclose(fp);
}

char *
cpu_temp() {
	int temp1, temp2, temp3, temp4;
	int average = 0;

    temp1 = get_temp("/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp2_input");
	temp2 = get_temp("/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp3_input");
	temp3 = get_temp("/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp4_input");
	temp4 = get_temp("/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp5_input");

	average = (temp1 + temp2 + temp3 + temp4) / 4;

	return smprintf("%dºC", average);
}