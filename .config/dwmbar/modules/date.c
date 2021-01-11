#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <time.h>

#include "util.h"

char *
get_date(char *fmt)
{
	char buf[20];
	time_t tim;
	struct tm *timtm;

	memset(buf, 0, sizeof(buf));
	tim = time(NULL);
	timtm = localtime(&tim);
	if (timtm == NULL) {
		perror("localtime");
		exit(1);
	}

	if (!strftime(buf, sizeof(buf)-1, fmt, timtm)) {
		fprintf(stderr, "strftime == 0\n");
		exit(1);
	}

	return smprintf(buf);
}