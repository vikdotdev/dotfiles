#!/bin/bash

CORRECT_DEVICES=
DEVICE=
MOUNT_POINT=

function display_mount_info {
  lsblk -l | awk '{print $1,$4,$7}' | grep 'sd[b-z][0-9]'

}

function create_mount_point {
  # create incremented folders: usb1, usb2, usb3, usb4
  MOUNT_POINT=
}

function clean_after_abort {
  # remove created folder if script was aborted
  # is it even possible?
}

function main {
  CORRECT_DEVICES=$(lsblk -l | awk '{print $1}' | grep 'sd[b-z][0-9]')
  DEVICE=$(echo "$CORRECT_DEVICES" | rofi_dmenu.sh "mount")



  echo "mounting $DEVICE on $MOUNT_POINT"
}

main

