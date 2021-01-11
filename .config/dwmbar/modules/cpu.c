#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>

#include "util.h"

char *
cpu_usage() {
    long double a[4], b[4];
	float loadavg;
    FILE *fp;

    fp = fopen("/proc/stat","r");
	fscanf(fp,"%*s %Lf %Lf %Lf %Lf",&a[0],&a[1],&a[2],&a[3]);
	fclose(fp);
	sleep(1);

	fp = fopen("/proc/stat","r");
	fscanf(fp,"%*s %Lf %Lf %Lf %Lf",&b[0],&b[1],&b[2],&b[3]);
	fclose(fp);

	loadavg = ((b[0]+b[1]+b[2]) - (a[0]+a[1]+a[2])) / ((b[0]+b[1]+b[2]+b[3]) - (a[0]+a[1]+a[2]+a[3]));
	
	return smprintf("%0.2f%%",loadavg * 100);
}