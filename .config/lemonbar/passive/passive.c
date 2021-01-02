#define _GNU_SOURCE     /* To get defns of NI_MAXSERV and NI_MAXHOST */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/statvfs.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include "passive.h"

/* Task function ================================================================================== */
void set_task(struct s_task *task,
              int timer,
              int base_timer,
              void (*func)(char*),
              char** str, int str_len, int *count){

  task->timer = timer ;
  task->base_timer = base_timer ;
  task->func = func ;
  task->str = malloc( str_len * sizeof(char));
  *count += 1;
}

/* Exec bash command ================================================================================== */
char* sh_exec(char *out){

    int pip[2], status ;
    char *res, *p ;
    pid_t pid ;
    pipe(pip);

    res = calloc( MAX_CMD_RES, sizeof(char));
    pid = fork();

    if(pid == 0){
        /* child process */
        dup2(pip[1], 1);
        close(pip[0]);
        close(pip[1]);
        execv("/bin/sh", (char* const[]){"/bin/sh","-c", out, 0});
        exit(EXIT_SUCCESS);
    }
    else {
        close(pip[1]);
        read(pip[0], res, 50);
        waitpid(pid, &status, 0);
        return res ;
    }
}


/* =============================== ====== ======================================= */
/* =============================== CONFIG ======================================= */
/* =============================== ====== ======================================= */

/* Date ====================================== */
void update_date(char *out){
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);
    snprintf(out, 50,
        THEME_DATE_BEGIN " %02d/%02d/%02d  %02d:%02d" THEME_DATE_END,
        tm.tm_mday,
        tm.tm_mon + 1,
        tm.tm_year + 1900 ,
        tm.tm_hour,
        tm.tm_min);
}

/* Battery ==================================*/
void get_battery(char *out){
    /* cmd needs to be in 1 line */
    char *cmd = "echo -n `cat /sys/class/power_supply/BAT0/capacity`";
    char *output = sh_exec(cmd);

    char* icon;

    if (*output > 90){
        icon = "";
    } else if (*output > 80) {
        icon = "";
    } else if (*output > 70) {
        icon = "";
    } else if (*output > 60) {
        icon = "";
    } else if (*output > 50) {
        icon = "";
    } else if (*output > 40) {
        icon = "";
    } else if (*output > 30) {
        icon = "";
    } else if (*output > 20) {
        icon = "";
    } else if (*output > 10) {
        icon = "";
    } else{
        icon = "";
    }

    snprintf(out, 30, THEME_BAT_BEGIN "%s %s%%" THEME_BAT_END, icon, output);
    free(output);
}

/* Network ==================================== */
void get_network(char *out){
    char *cmd = "echo -n `iwconfig wlo1 | grep -o '[0-9]*/70' | cut -d / -f 1`";
    char *output = sh_exec(cmd);
    char* icon;

    if (*output > 55){
        icon = "";
    } else if (*output > 40){
        icon = "";
    } else if (*output > 20){
        icon = "";
    } else if (*output > 0){
        icon = "";
    } else{
        icon = "睊";
    }

    snprintf(out, 30, THEME_NET_BEGIN "%s" THEME_NET_END, icon);
    free(output);
}

/* Temp ===================================*/
void cpu_temp(char *out) {
    char *cmd = "echo -n `cat /sys/devices/platform/coretemp.0/hwmon/hwmon4/temp2_input | cut -c 1-2`";
    char *output = sh_exec(cmd);

    snprintf(out, 40, THEME_TEMP_BEGIN "%%{r}  %sºC" THEME_TEMP_END, output);
    free(output);
}

/* Bspcwm (moved to active) ===================================
void get_workspaces(char *out){
    char *cmd1 = "echo -n `bspc query -D --names`";
    char *all = sh_exec(cmd1);

    char *cmd2 = "echo -n `bspc query -D --names -d focused`";
    char *focused = sh_exec(cmd1);

    snprintf(out, 30, "%%{l} %s", all);
    free(all);
    free(focused);
}
*/

/* =============================== ==== ======================================= */
/* =============================== MAIN ======================================= */
/* =============================== ==== ======================================= */

/* Add task =================================================================== */
void add_task(struct s_task *tasks, struct s_task t){
    static int count = 0 ;
    tasks[count++] = t ;
}


/* Main ======================================================================= */
int main(void){

    int i, mod;
    struct s_task bar_network, bar_date, bar_battery, bar_temp;
    struct s_task *tasks;

    char ban[TOTAL_LENGTH];
    char *ban_p ;
    
    mod = i = 0 ;
    /* blck struc | 1 -> update after start | update after _ | function | output string | max length | mod */    
    set_task( &bar_temp, 1, 2, cpu_temp, &bar_temp.str, 40, &mod );
    set_task( &bar_network, 1, 5, get_network, &bar_network.str, 10, &mod);
    set_task( &bar_battery, 1, 120, get_battery, &bar_battery.str, 5, &mod);
    set_task( &bar_date, 1, 60, update_date, &bar_date.str, 30, &mod);

    tasks = malloc( mod * sizeof(struct s_task));

    ENABLE_WIDGET(bar_temp);
    ENABLE_WIDGET(bar_network);
    ENABLE_WIDGET(bar_battery);
    ENABLE_WIDGET(bar_date);


    while(1){
        memset(ban,0,TOTAL_LENGTH);
        ban_p = ban ;
        for(i = 0 ; i < mod ; i++){

            tasks[i].timer--;
            if(!tasks[i].timer){
                tasks[i].timer = tasks[i].base_timer ;
                tasks[i].func(tasks[i].str);
            }
            strcat(ban_p, tasks[i].str);
            ban_p += strlen(tasks[i].str);
        }
        printf("%s\n", ban);
        fflush(stdout);
        sleep(1);
    }

}