/* See LICENSE file for copyright and license details. */

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <time.h>

#include "bspwmbar.h"
#include "util.h"

static const char *deffgcols[3] = {
	"#e5e5e5", /* normal color */
	"#f5a70a", /* warning color */
	"#ed5456", /* critical color */
};

void
thermal(draw_context_t *dc, module_option_t *opts)
{
	static time_t prevtime;
	static unsigned long temp1, temp2, temp3, temp4;
	static int thermal_found = -1;

	static unsigned long average = 0;

	color_t *fgcols;

	char* sensor1 = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp2_input";
	char* sensor2 = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp3_input";
	char* sensor3 = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp4_input";
	char* sensor4 = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp5_input";

	if (thermal_found == -1) {
		if (access(sensor1, F_OK) != -1)
			thermal_found = 1;
		else
			thermal_found = 0;
	}
	if (!thermal_found)
		return;

	time_t curtime = time(NULL);
	if (curtime - prevtime < 1)
		goto DRAW_THERMAL;
	prevtime = curtime;


	if (pscanf(sensor1, "%ju", &temp1) == -1)
		return;
	
	if (pscanf(sensor2, "%ju", &temp2) == -1)
		return;
	
	if (pscanf(sensor3, "%ju", &temp3) == -1)
		return;
	
	if (pscanf(sensor4, "%ju", &temp4) == -1)
		return;


DRAW_THERMAL:

	average = (temp1 + temp2 + temp3 + temp4) / 4000;

	if (average > 80){
		fgcols = color_load(deffgcols[2]);
	} else if (average > 60){
		fgcols = color_load(deffgcols[1]);
	} else{
		fgcols = color_load(deffgcols[0]);
	}

	if (!opts->thermal.prefix)
		opts->thermal.prefix = "";
	if (!opts->thermal.suffix)
		opts->thermal.suffix = "";
	
	sprintf(buf, "%s%lu%s", opts->thermal.prefix, average, opts->thermal.suffix);
	draw_color_text(dc, fgcols, buf);
}