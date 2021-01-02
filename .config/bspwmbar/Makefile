.POSIX:

VERSION   =1.0

DESTDIR   =
PREFIX    =/home/josema/bspwmbar/obj

BINPREFIX=/home/josema/

CFLAGS   =-Os -Wall -Wextra -pedantic -pipe -fstack-protector-strong -fno-plt -DNDEBUG -I/usr/include/cairo -I/usr/include/lzo -I/usr/include/libpng16 -I/usr/include/freetype2 -I/usr/include/harfbuzz -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/pixman-1 
LDFLAGS  =-s -lxcb-ewmh -lxcb-util -lxcb-randr -lxcb-shm -lxcb-render-util -lxcb -lxcb-render -lcairo -lharfbuzz -lfontconfig -lfreetype -lasound 
DCFLAGS  =-g -fsanitize=address -fno-omit-frame-pointer -I/usr/include/cairo -I/usr/include/lzo -I/usr/include/libpng16 -I/usr/include/freetype2 -I/usr/include/harfbuzz -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/pixman-1 
DLDFLAGS = -fsanitize=address -lxcb-ewmh -lxcb-util -lxcb-randr -lxcb-shm -lxcb-render-util -lxcb -lxcb-render -lcairo -lharfbuzz -lfontconfig -lfreetype -lasound 

CC=cc

MODS=bspwm cpu memory disk thermal datetime battery backlight alsa
OBJ = bspwmbar.o util.o systray.o $(MODS:=.o)

bspwmbar: config.h util.h bspwmbar.h $(OBJ)
	$(CC) -o $@ $(OBJ) $(CFLAGS) $(LDFLAGS) -DVERSION='"$(VERSION)"'
	rm *.o

debug:
	@make CFLAGS="$(DCFLAGS)" LDFLAGS="$(DLDFLAGS)"
.PHONY: debug

config.h:
	cp config.def.h $@

config: config.def.h
	cp config.def.h config.h
.PHONY: config

clean:
	rm -f bspwmar $(OBJ)
.PHONY: clean

run: bspwmbar
	./bspwmbar

install:
	cp bspwmbar /home/josema/.config/lemonbar/
.PHONY: install

uninstall:
	rm -f $(DESTDIR)$(BINPREFIX)/bspwmbar
.PHONY: uninstall