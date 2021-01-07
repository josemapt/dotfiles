#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

int get_temp(char* sensor) {
	int temperature;
	FILE *fp;

	fp = fopen(sensor, "r");
	fscanf(fp, "%d", &temperature);
	fclose(fp);

	return temperature / 1000;
}

int main() {
	int temp1, temp2, temp3, temp4;

    char* prefix = " ";
	int average = 0;

    temp1 = get_temp("/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp2_input");
	temp2 = get_temp("/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp3_input");
	temp3 = get_temp("/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp4_input");
	temp4 = get_temp("/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp5_input");


	average = (temp1 + temp2 + temp3 + temp4) / 4;
	
	printf("%s%dºC", prefix, average);

	return 0;
}