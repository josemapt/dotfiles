/* See LICENSE file for copyright and license details. */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
# include <alloca.h>
# include <sys/sysinfo.h>

#include "bspwmbar.h"
#include "util.h"

typedef struct {
	double user;
	double nice;
	double system;
	double idle;
	double iowait;
	double irq;
	double softirq;
	double sum;
} CoreInfo;

/* functions */
static int num_procs();
static int cpu_perc(double **);

static const char *deffgcols[4] = {
	"#449f3d", /* success color */
	"#2f8419", /* normal color */
	"#f5a70a", /* warning color */
	"#ed5456", /* critical color */
};
static double *loadavgs = NULL;

int
num_procs()
{
	static int nproc = 0;

	if (nproc)
		return nproc;

	nproc = get_nprocs();
	return nproc;
}

int
cpu_perc(double **cores)
{
	static CoreInfo *a = NULL;
	static CoreInfo *b = NULL;
	static time_t prevtime;
	int i = 0;
	int nproc;

	if ((nproc = num_procs()) == -1)
		return 0;

	time_t curtime = time(NULL);
	if (curtime - prevtime < 1) {
		*cores = loadavgs;
		return nproc;
	}
	prevtime = curtime;

	if (a == NULL)
		a = (CoreInfo *)calloc(sizeof(CoreInfo), nproc);
	if (b == NULL)
		b = (CoreInfo *)calloc(sizeof(CoreInfo), nproc);
	if (loadavgs == NULL)
		loadavgs = (double *)calloc(sizeof(double), nproc);

	memcpy(b, a, sizeof(CoreInfo) * nproc);

	FILE *fp;
	if (!(fp = fopen("/proc/stat", "r")))
		return 0;

	while (fgets(buf, sizeof(buf), fp)) {
		if (strncmp(buf, "cpu ", 4) == 0)
			continue;
		if (strncmp(buf, "cpu", 3) != 0)
			break;
		sscanf(buf, "%*s %lf %lf %lf %lf %lf %lf %lf", &a[i].user, &a[i].nice,
		       &a[i].system, &a[i].idle, &a[i].iowait, &a[i].irq,
		       &a[i].softirq);
		b[i].sum = (b[i].user + b[i].nice + b[i].system + b[i].idle +
		            b[i].iowait + b[i].irq + b[i].softirq);
		a[i].sum = (a[i].user + a[i].nice + a[i].system + a[i].idle +
		            a[i].iowait + a[i].irq + a[i].softirq);
		double used =
		  (b[i].user + b[i].nice + b[i].system + b[i].irq + b[i].softirq) -
		  (a[i].user + a[i].nice + a[i].system + a[i].irq + a[i].softirq);
		loadavgs[i] = used / (b[i].sum - a[i].sum);
		i++;
	}
	fclose(fp);

	*cores = loadavgs;
	return nproc;
}

void
cpu_usage(draw_context_t *dc, module_option_t *opts)
{
	color_t *fgcols[4];
	color_t *bgcol;
	double *vals = NULL;
	int i, ncore = cpu_perc(&vals);

	bgcol = color_load("#292d3e");
	for (i = 0; i < 4; i++) {
		if (opts->cpu.cols[i])
			fgcols[i] = color_load(opts->cpu.cols[i]);
		else
			fgcols[i] = color_load(deffgcols[i]);
	}

	graph_item_t *items = (graph_item_t *)alloca(sizeof(graph_item_t) * ncore);
	for (int i = 0; i < ncore; i++) {
		items[i].bg = bgcol;
		items[i].val = vals[i];
		if (vals[i] < 0.3) {
			items[i].fg = fgcols[0];
		} else if (vals[i] < 0.6) {
			items[i].fg = fgcols[1];
		} else if (vals[i] < 0.8) {
			items[i].fg = fgcols[2];
		} else {
			items[i].fg = fgcols[3];
		}
	}

	if (!opts->cpu.prefix)
		opts->cpu.prefix = "";
	draw_bargraph(dc, opts->cpu.prefix, items, ncore);
}