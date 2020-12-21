#!/bin/bash

if [[ `sudo fdisk -l | grep "/dev/sda"` != "" ]]; then
    [[ `df | grep "/dev/sda"` = "" ]] && canberra-gtk-play -i power-plug && udisksctl mount -b /dev/sda1 >& /dev/null
    echo "   "
else
    echo ""
fi