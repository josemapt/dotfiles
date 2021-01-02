#ifndef __BAR_H__
#define __BAR_H__

#define TOTAL_LENGTH 500

#define THEME_DATE_BEGIN "%%{B#FF0000} "
#define THEME_DATE_END   " %%{B-}"

#define THEME_BAT_BEGIN "%%{B#00AA00} "
#define THEME_BAT_END   " %%{B-}"

#define THEME_NET_BEGIN "%%{B#11AABB} "
#define THEME_NET_END   " %%{B-}"

#define THEME_TEMP_BEGIN "%%{B#FAA400} "
#define THEME_TEMP_END   " %%{B-}"


#define MAX_CMD_RES 50
#define ENABLE_WIDGET(x) tasks[i++] = x

struct s_task {
	int timer, base_timer;
	void (*func)(char*);
	char *str;
};


void set_task(struct s_task *task,int timer,
              int base_timer,
              void (*func)(char*),
              char** str,
              int str_len, int *count);


void get_ip_addr(char *str);
void update_date(char *out);
void update_acpi(char *out);

#endif