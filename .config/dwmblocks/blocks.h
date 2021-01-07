static const Block blocks[] = {
	/*Icon*/	/*Command*/					/*Update Interval*/	/*Update Signal*/
	{"",	"~/.config/dwmblocks/ex/cpu_temp",	    1,		    	0},
	{"",	"~/.config/dwmblocks/ex/net",	     	4,		    	0},
	{"",	"~/.config/dwmblocks/ex/alsa",	    	0,		    	5},
	{"", 	"~/.config/dwmblocks/ex/battery",		1,		    	0},
	{" ",	"~/.config/dwmblocks/ex/date",	    	60,		    	0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;