#!/bin/bash

if [[ `sudo fdisk -l | grep "/dev/sda"` != "" ]]; then
    [[ `df | grep "/dev/sda"` = "" ]] && sudo mount /dev/sda1 /media/usb_drive >& /dev/null && notify-send "hard drive detected" "Mounted in /media/usb_drive" && canberra-gtk-play -i power-plug
    echo "  "
else
    echo ""
fi