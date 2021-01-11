#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <strings.h>

#include "util.h"

char *
smprintf(char *fmt, ...){
	va_list fmtargs;
	char *buf = NULL;

	va_start(fmtargs, fmt);
	if (vasprintf(&buf, fmt, fmtargs) == -1){
		fprintf(stderr, "malloc vasprintf\n");
		exit(1);
    }
	va_end(fmtargs);

	return buf;
}