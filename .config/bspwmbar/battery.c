/* See LICENSE file for copyright and license details. */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <time.h>

#include "bspwmbar.h"
#include "util.h"

typedef enum {
	BAT_UNKNOWN,
	BAT_CHARGING,
	BAT_DISCHARGING,
	BAT_FULL,
} battery_status_t;

typedef struct {
	battery_status_t status;
	uint32_t capacity;
} battery_t;

static const char *deffgcols[3] = {
	"#e5e5e5", /* normal color */
	"#f5a70a", /* warning color */
	"#ed5456", /* critical color */
};

static bool battery_load_info(battery_t *, const char *);
static void battery_draw(battery_t *, draw_context_t *, module_option_t *);

static battery_t bat;
bool charging_status = false;

void
battery(draw_context_t *dc, module_option_t *opts)
{
	static time_t prevtime;
	time_t curtime;

	if (!opts->battery.path)
		return;

	curtime = time(NULL);
	if (curtime - prevtime < 1) {
		battery_draw(&bat, dc, opts);
		return;
	}
	prevtime = curtime;

	if (battery_load_info(&bat, opts->battery.path))
		battery_draw(&bat, dc, opts);
}

const char *
battery_prefix(battery_t *bat, module_option_t *opts)
{
	char *prefix = NULL;

	switch (bat->capacity / 10) {
	case 0:
		prefix = opts->battery.prefix;
		break;
	case 1:
		prefix = opts->battery.prefix_1;
		break;
	case 2:
		prefix = opts->battery.prefix_2;
		break;
	case 3:
		prefix = opts->battery.prefix_3;
		break;
	case 4:
		prefix = opts->battery.prefix_4;
		break;
	case 5:
		prefix = opts->battery.prefix_5;
		break;
	case 6:
		prefix = opts->battery.prefix_6;
		break;
	case 7:
		prefix = opts->battery.prefix_7;
		break;
	case 8:
		prefix = opts->battery.prefix_8;
		break;
	case 9:
		prefix = opts->battery.prefix_9;
		break;
	case 10:
		prefix = opts->battery.prefix_10;
		break;
	default:
		prefix = opts->battery.prefix;
	}
	prefix = prefix ? prefix : opts->battery.prefix;
	return prefix ? prefix : "";
}

void
battery_draw(battery_t *bat, draw_context_t *dc, module_option_t *opts)
{
	color_t *fgcols;

	if (bat->capacity < 10){
		fgcols = color_load(deffgcols[2]);
	} else if (bat->capacity < 30){
		fgcols = color_load(deffgcols[1]);
	} else{
		fgcols = color_load(deffgcols[0]);
	}

	if (!charging_status)
		opts->battery.charging_icon = " ";

	sprintf(buf, "%s%s%d%s",
		battery_prefix(bat, opts),
		opts->battery.charging_icon,
		bat->capacity,
		opts->battery.suffix ? opts->battery.suffix : "");
	draw_color_text(dc, fgcols, buf);
}

typedef enum {
	BAT_KEY_UNKNOWN,
	BAT_KEY_STATUS,
	BAT_KEY_SUPPLY_CHARGE_FULL,
	BAT_KEY_SUPPLY_CHARGE_NOW,
} battery_key_t;

static battery_key_t
battery_parse_key(const char *str)
{
	if (!str)
		return BAT_KEY_UNKNOWN;

	if (!strncmp("POWER_SUPPLY_STATUS", str, strlen(str)))
		return BAT_KEY_STATUS;

	if (!strncmp("POWER_SUPPLY_CHARGE_NOW", str, strlen(str)))
		return BAT_KEY_SUPPLY_CHARGE_NOW;

	if (!strncmp("POWER_SUPPLY_CHARGE_FULL", str, strlen(str)))
		return BAT_KEY_SUPPLY_CHARGE_FULL;

	return BAT_KEY_UNKNOWN;
}

static battery_status_t
battery_parse_status(const char *str)
{
	if (!str)
		return BAT_UNKNOWN;

	if (!strncmp("Discharging", str, strlen(str)))
		return BAT_DISCHARGING;
	if (!strncmp("Charging", str, strlen(str))){
		charging_status = true;
		return BAT_CHARGING;
	}
	if (!strncmp("Full", str, strlen(str)))
		return BAT_FULL;

	return BAT_UNKNOWN;
}

bool
battery_load_info(battery_t *bat, const char *path)
{
	FILE *fp;
	char key[32] = { 0 };
	char val[32] = { 0 };
	uint32_t full = 0, now = 0;

	if (!(fp = fopen(path, "r")))
		return false;

	while (fgets(buf, sizeof(buf), fp)) {
		sscanf(buf, "%[^=]=%s", key, val);

		switch (battery_parse_key(key)) {
		case BAT_KEY_STATUS:
			bat->status = battery_parse_status(val);
			break;
		case BAT_KEY_SUPPLY_CHARGE_FULL:
			full = atoi(val);
			break;
		case BAT_KEY_SUPPLY_CHARGE_NOW:
			now = atoi(val);
			break;
		default:
			break;
		}
	}
	fclose(fp);

	bat->capacity = now * 100 / full;

	return true;
}