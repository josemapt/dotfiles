#ifndef UTIL_H_INCLUDED
#define UTIL_H_INCLUDED

char *smprintf(char *fmt, ...);

char *get_date(char *fmt);
char *get_battery();
char *get_network();
char *cpu_temp();
char *cpu_usage();

#endif