#!/bin/bash

DEVBASE=$2
DEVICE="/dev/${DEVBASE}"

# See if this drive is already mounted, and if so where
MOUNT_POINT=$(mount | grep ${DEVICE} | awk '{ print $3 }')

DEV_LABEL=""

do_mount()
{
    # Get info for this drive: $ID_FS_LABEL and $ID_FS_TYPE
    eval $(blkid -o udev ${DEVICE} | grep -i -e "ID_FS_LABEL" -e "ID_FS_TYPE")

    # Figure out a mount point to use
    LABEL=${ID_FS_LABEL}
    if grep -q " /media/${LABEL} " /etc/mtab; then
        # Already in use, make a unique one
        LABEL+="-${DEVBASE}"
    fi
    DEV_LABEL="${LABEL}"

    # Use the device name in case the drive doesn't have label
    if [ -z ${DEV_LABEL} ]; then
        DEV_LABEL="${DEVBASE}"
    fi

    MOUNT_POINT="/media/${DEV_LABEL}"


    mkdir -p ${MOUNT_POINT}

    mount ${DEVICE} ${MOUNT_POINT}
}

do_unmount()
{
    mount_dir="/media/${2}"
    
    umount ${mount_dir}
    rmdir ${mount_dir}
}

case ${1} in
    add)
        do_mount
        ;;
    remove)
        do_unmount
        ;;
esac
