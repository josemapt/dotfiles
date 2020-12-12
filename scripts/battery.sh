#!/bin/sh

while true; do
    battery_level=`acpi -b | cut -d ' ' -f 4 | grep -o '[0-9]*'`
    battery_status=`acpi -b | grep -c 'Charging'`

    if [[ $battery_status -eq 1 && $battery_level -ge 80 ]];
    then
        notify-send "Battery high" "Battery level is ${battery_level}%!"
    fi

    if [[ $battery_status -eq 0 && $battery_level -le 30 ]];
    then
        notify-send "Battery low" "Battery level is ${battery_level}%!"
    fi
    sleep 60;
done