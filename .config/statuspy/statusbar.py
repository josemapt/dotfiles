#!/bin/python

import time
import datetime

def readfile(file):
    with open(file, "r") as f:
        content = f.read()[:-1]
    
    return content


def cpu_temp():
    temp1 = readfile("/sys/class/hwmon/hwmon5/temp2_input")
    temp2 = readfile("/sys/class/hwmon/hwmon5/temp3_input")
    temp3 = readfile("/sys/class/hwmon/hwmon5/temp4_input")
    temp4 = readfile("/sys/class/hwmon/hwmon5/temp5_input")

    average = (int(temp1) + int(temp2) + int(temp3) + int(temp4)) / 4000

    return " " + str(average)[:2] + "ºC "

def battery():
    capacity = readfile("/sys/class/power_supply/BAT0/capacity")

    icon_list = [ " ", " ", " ", " ", " ", " ", " ", " ", " ", " " ]

    return icon_list[int(capacity[0])] + capacity + "% "

def date():
    current_date = datetime.datetime.now()

    return " " + "{:d}:{:02d}".format(current_date.hour, current_date.minute) + " "


def content():
    return cpu_temp() + " | " + battery() + " | " + date()

while True:
    with open("/home/josema/swaypipe", "w") as fifo:
        fifo.write(content())
        fifo.flush()
    
    time.sleep(1)
