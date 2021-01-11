#include "util.h"


/* DELIMITERENDCHAR must be less than 32.
 * At max, DELIMITERENDCHAR - 1 number of clickable blocks will be allowed.
 * Raw characters larger than DELIMITERENDCHAR and smaller than ' ' in ASCII
   character set can be used for signaling color change in status.
 * The character corresponding to DELIMITERENDCHAR + 1 ('\x0b' when
   DELIMITERENDCHAR is 10) will switch the active colorscheme to the first one
   defined in colors array in dwm's config.h and so on.
 * If you wish to change DELIMITERENDCHAR, don't forget to update its value in
   dwm.c and color codes in util.h. */
#define DELIMITERENDCHAR                10

/* If interval of a block is set to 0, the block will only be updated once at
   startup.
 * If interval is set to a negative value, the block will never be updated in
   the main loop.
 * Set funcc to NULL if clickability is not required for the block.
 * Set signal to 0 if both clickability and signaling are not required for the
   block.
 * Signal must be less than DELIMITERENDCHAR for clickable blocks.
 * If multiple signals are pending, then the lowest numbered one will be
   delivered first. */

/* func - function responsible for updating status text of the block
 * func_c - function responsible for handling clicks on the block */

/* 1 interval = INTERVALs seconds, INTERVALn nanoseconds */
#define INTERVALs                       1
#define INTERVALn                       0

static Block blocks[] = {
/*      func                   func_c                   interval        signal */
        { cpu_temp,            cpu_temp_c,              1,              5 },
        { network,             network_c,               4,              4 },
        { battery,             battery_c,               10,             3 },
        { date,                date_c,                  60,             2 },
        { powerbutton,         powerbutton_c,           0,              1 },
        { NULL } /* just to mark the end of the array */
};

/* default delimiter string */
#define DELIMITER                       " | "
