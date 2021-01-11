#include "shared.h"

#define COL0                            "\x0b"
#define COL1                            "\x0c"
#define COL2                            "\x0d"
#define COL3                            "\x0e"
#define COL4                            "\x0f"

#define LENGTH(X)                       (sizeof X / sizeof X[0])

void cspawn(char *const *arg);
void csigself(int sig, int sigval);
size_t getcmdout(char *const *arg, char *cmdout, size_t cmdoutlen);
int readint(const char *path, int *var);
void uspawn(char *const *arg);

/* Functions */
void powerbutton(char *str);
void powerbutton_c();

void date(char *str);
void date_c();

void battery(char *str, int ac);
void battery_c();

void network(char *str);
void network_c();

void cpu_temp(char *str);
void cpu_temp_c();