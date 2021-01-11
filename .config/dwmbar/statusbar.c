#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <strings.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#include <X11/Xlib.h>

#include "modules/util.h"


static Display *dpy;

void
setstatus(char *str)
{
	XStoreName(dpy, DefaultRootWindow(dpy), str);
	XSync(dpy, False);
}

int runevery(time_t *ltime, int sec){
    /* return 1 if sec elapsed since last run
     * else return 0 
    */
    time_t now = time(NULL);
    
    if ( difftime(now, *ltime ) >= sec)
    {
        *ltime = now;
        return(1);
    }
    else 
        return(0);
}


int main() {
	char *status = NULL;
	char *date = NULL;
    char *bat = NULL;
	char *net = NULL;
	char *temp = NULL;
	char *cpu = NULL;

    //time_t count5min = 0;
    time_t count60 = 0;
    time_t count5 = 0;
    
	if (!(dpy = XOpenDisplay(NULL))) {
		fprintf(stderr, "dwmstatus: cannot open display.\n");
		return 1;
	}

	for (;;sleep(1)) {
	    /* checks every minutes */
	    if ( runevery(&count60, 60) )
        {
            free(date);
            free(bat);
            //date = get_date("%d/%m/%y %H:%M");
			date = get_date("%H:%M");
            bat = get_battery();
        }
		/* checks every 5 seconds */
	    if ( runevery(&count5, 5) )
        {
            free(net);
			net = get_network();
        }
        /* checks every second */
		temp = cpu_temp();
		cpu = cpu_usage();

		status = smprintf("  %s |  %s | %s | %s |   %s ", cpu, temp, net, bat, date);

		setstatus(status);
		free(temp);
		free(cpu);
		free(status);
	}

	XCloseDisplay(dpy);

	return 0;
}