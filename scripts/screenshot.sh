#!/bin/bash

canberra-gtk-play -i screen-capture

DIR=~/images/
DATE=`date +'%d_%m_%Y'`
NAME="${DATE}_grim.png"

if [[ ! -d ${DIR} ]]
then
    mkdir ${DIR}
fi

if [[ ! -f ${DIR}${NAME} ]]
then
    grim ${DIR}${NAME}
else
    # save image with a different name
    N=1
    NAME="${DATE}_grim_${N}.png"

    while [[ -f ${DIR}${NAME} ]]
    do
        NAME="${DATE}_grim_$((N++)).png"
    done

    grim ${DIR}${NAME}
fi