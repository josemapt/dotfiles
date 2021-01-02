#!/bin/sh
# vim: st=2 sw=2 sts=2 et

VERSION="1.0"
PREFIX=/home/josema/bspwmbar/obj

PKGCONFIG='pkg-config'
DEPS='xcb xcb-ewmh xcb-util xcb-randr xcb-shm xcb-renderutil cairo harfbuzz fontconfig'
MODS='bspwm cpu memory disk thermal datetime battery backlight'

# debug flags
CFLAGS='-Os -Wall -Wextra -pedantic -pipe -fstack-protector-strong -fno-plt -DNDEBUG'
LDFLAGS='-s'

# debug flags
DCFLAGS='-g'
DLDFLAGS=''

usage_exit() {
  echo "usage: ./configure [option]...

    --prefix=<path>     install target prefix
"
  exint 1
}

set_args() {
  while [ "${1:-}" != "" ]; do
    case "$1" in
      "-p" | "--prefix")
        shift
        [ -z "${1:-}" ] && usage_exit
        prefix="${1}"
        ;;
    esac
    shift
  done
}

set_args ${@}

case $(uname -s) in
  Linux)
    DEPS="${DEPS} alsa"
    MODS="${MODS} alsa"
    DCFLAGS="${DCFLAGS} -fsanitize=address -fno-omit-frame-pointer"
    DLDFLAGS="${DLDFLAGS} -fsanitize=address"
    ;;
  OpenBSD)
    MODS="${MODS} volume"
    ;;
esac

DEPCFLAGS="$("${PKGCONFIG}" --cflags "${DEPS}")"
DEPLIBS="$("${PKGCONFIG}" --libs "${DEPS}")"
CFLAGS="${CFLAGS} ${DEPCFLAGS}"
LDFLAGS="${LDFLAGS} ${DEPLIBS}"
DCFLAGS="${DCFLAGS} ${DEPCFLAGS}"
DLDFLAGS="${DLDFLAGS} ${DEPLIBS}"

export VERSION PREFIX CFLAGS LDFLAGS MODS DCFLAGS DLDFLAGS
envsubst < Makefile.in > Makefile
