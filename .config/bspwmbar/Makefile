.POSIX:

VERSION   =1.0

DESTDIR   =
PREFIX    =/home/josema/.config/bspwmbar/

BINPREFIX=/home/josema/

CFLAGS   =-Os -Wall -Wextra -pedantic -pipe -fstack-protector-strong -fno-plt -DNDEBUG -I/usr/include/cairo -I/usr/include/lzo -I/usr/include/libpng16 -I/usr/include/freetype2 -I/usr/include/harfbuzz -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/pixman-1 
LDFLAGS  =-s -lxcb-ewmh -lxcb-util -lxcb-randr -lxcb-shm -lxcb-render-util -lxcb -lxcb-render -lcairo -lharfbuzz -lfontconfig -lfreetype -lasound 
DCFLAGS  =-g -fsanitize=address -fno-omit-frame-pointer -I/usr/include/cairo -I/usr/include/lzo -I/usr/include/libpng16 -I/usr/include/freetype2 -I/usr/include/harfbuzz -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I/usr/include/pixman-1 
DLDFLAGS = -fsanitize=address -lxcb-ewmh -lxcb-util -lxcb-randr -lxcb-shm -lxcb-render-util -lxcb -lxcb-render -lcairo -lharfbuzz -lfontconfig -lfreetype -lasound 

CC=cc

MODS=bspwm cpu thermal datetime battery alsa net
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
	cp bspwmbar /usr/local/bin/
.PHONY: install

uninstall:
	rm -f /usr/local/bin/bspwmbar
.PHONY: uninstall