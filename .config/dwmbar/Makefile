statusbar: statusbar.c modules/*.c
	cc statusbar.c modules/*.c -o statusbar -lX11 -Wall -O2

install: statusbar
	cp -f statusbar /usr/local/bin/

unistall:
	rm -f /usr/local/bin/statusbar