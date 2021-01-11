PREFIX := /usr/local

CC := gcc
CFLAGS := -O2 -Wall -Wextra

X11CFLAGS := $(shell pkg-config --cflags x11)
X11LIBS := $(shell pkg-config --libs x11)

BLOCKS := $(wildcard blocks/*.c)

all: dsblocks

dsblocks.o: dsblocks.c blocks.h shared.h
	${CC} -o $@ -c -Wno-missing-field-initializers -Wno-unused-parameter ${CFLAGS} ${X11CFLAGS} $<

util.o: util.c util.h shared.h
	${CC} -o $@ -c ${CFLAGS} ${X11CFLAGS} $<

blocks/%.o: blocks/%.c blocks/%.h util.h shared.h
	${CC} -o $@ -c -Wno-unused-parameter ${CFLAGS} $<

dsblocks: dsblocks.o util.o ${BLOCKS:c=o}
	${CC} -o $@ $^ ${X11LIBS}


clean:
	rm -f blocks/*.o *.o

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	install -m 0755 dsblocks ${DESTDIR}${PREFIX}/bin/dsblocks

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dsblocks

.PHONY: all clean install uninstall
