#!/bin/sh

# https://github.com/graupe/brownout

period=`is-day 52.520008 13.404954`

case $period in
    dawn)   brownout 300 ;;
    day)    brownout 200 ;;
    sunset) brownout 300 ;;
    dusk)   brownout 400 ;;
    night)  brownout 500 ;;
esac