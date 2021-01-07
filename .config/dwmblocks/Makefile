PREFIX ?= /usr/local
CC ?= cc
LDFLAGS = -lX11

output: dwmblocks.c blocks.h modules/*.c
	${CC} dwmblocks.c $(LDFLAGS) -o dwmblocks

	${CC} modules/date.c -o ex/date
	${CC} modules/battery.c -o ex/battery
	${CC} modules/alsa.c -o ex/alsa -lasound
	${CC} modules/net.c -o ex/net
	${CC} modules/cpu_temp.c -o ex/cpu_temp

clean:
	rm -f *.o *.gch dwmblocks
install: output
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 0755 dwmblocks $(DESTDIR)$(PREFIX)/bin/dwmblocks
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwmblocks