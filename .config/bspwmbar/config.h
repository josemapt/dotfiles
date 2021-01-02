/* See LICENSE file for copyright and license details. */

#ifndef BSPWMBAR_CONFIG_H_
#define BSPWMBAR_CONFIG_H_

#include "bspwmbar.h"

/* intel */
#define THERMAL_PATH "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp2_input"
/* k10temp */
/* #define THERMAL_PATH "/sys/class/hwmon/hwmon1/temp1_input" */

/* max length of monitor output name and bspwm desktop name */
#define NAME_MAXSZ  32
/* max length of active window title */
#define TITLE_MAXSZ 50
/* set window height */
#define BAR_HEIGHT  35

/* set font pattern for find fonts, see fonts-conf(5) */
const char *fontname = "UbuntuMono Nerd Font:size=16";

/*
 * color settings by index of color map
 */
/* bspwmbar fg color */
#define FGCOLOR    "#e5e5e5"
/* bspwmbar bg color */
#define BGCOLOR    "#292d3e"
/* inactive fg color */
#define ALTFGCOLOR "#7f7f7f"
/* graph bg color */
#define ALTBGCOLOR "#555555"

/*
 * Module definition
 */

/* modules on the left */
module_t left_modules[] = {
	{ /* Arch logo */
		.text = {
			.func = text,
			.label = " ",
			.fg = "#1793d1",
		},
	},
	{ /* bspwm desktop state */
		.desk = {
			.func = desktops,
			.focused = " ",
			.unfocused = " ",
			.fg_free = ALTFGCOLOR,
		},
	},
	{ /* empty spàce */
		.text = {
			.func = text,
			.label = "  ",
		},
	},
	{ /* active window title */
		.title = {
			.func = windowtitle,
			.maxlen   = TITLE_MAXSZ,
			.ellipsis = "…",
		},
	},
};

/* modules on the right */
module_t right_modules[] = {
	{ /* system tray */
		.tray = {
			.func = systray,
			.iconsize = 16,
		},
	},
	{ /* cpu usage */
		.cpu = {
			.func = cpugraph,
			.prefix = "cpu: "
		},
	},
	{ /* memory usage */
		.mem = {
			.func = memgraph,
			.prefix = "mem: "
		},
	},
	{ /* Sep */
		.text = {
			.func = text,
			.label = "|",
		},
	},
	{ /* battery */
		.battery = {
			.func = battery,
			.prefix = " ",
			.prefix_1 = " ",
			.prefix_2 = " ",
			.prefix_3 = " ",
			.prefix_4 = " ",
			.suffix = "%",
			.path = "/sys/class/power_supply/BAT0/uevent",
		},
	},
	{ /* Sep */
		.text = {
			.func = text,
			.label = "|",
		},
	},
	{ /* master playback volume */
		.vol = {
			.func = volume,
			.handler = volume_ev,
			.suffix = "%",
			.muted = "婢 ",
			.unmuted = "墳 ",
		},
	},
	{ /* Sep */
		.text = {
			.func = text,
			.label = "|",
		},
	},
	{ /* used space of root file system */
		.fs = {
			.func = filesystem,
			.mountpoint = "/",
			.prefix = "  ",
			.suffix = "%",
		},
	},
	{ /* Sep */
		.text = {
			.func = text,
			.label = "|",
		},
	},
	{ /* cpu temperature */
		.thermal = {
			.func = thermal,
			.sensor = THERMAL_PATH,
			.prefix = " ",
			.suffix = "ºC",
		},
	},
	{ /* Sep */
		.text = {
			.func = text,
			.label = "|",
		},
	},
	{ /* clock */
		.date = {
			.func = datetime,
			.prefix = "  ",
			.format = "%H:%M",
		},
	},
};

#endif