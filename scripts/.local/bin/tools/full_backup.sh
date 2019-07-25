#!/bin/bash

MOUNT_POINT="/mnt/backup"
BACKUP_CONTENTS="/home/vik/" # note the trailing space here
LS=$(lsblk -l | awk '{print $1,$4,$7}' | grep 'sd[b-z][0-9]')
CORRECT_DEVICES=$(lsblk -l | awk '{print $1}' | grep 'sd[b-z][0-9]')
DEVICE=

function list_devices {
  echo "DEV  SIZE  MOUNTED"
  local list=$(lsblk -l | awk '{print $1,$4,$7}' | grep 'sd[b-z][0-9]')
  echo "$list"
}

function read_device_name {
  # echo -e -n "\nChoose a device name to mount onto "$MOUNT_POINT": "
  # read DEVICE
  DEVICE=$(echo "$CORRECT_DEVICES" | rofi_dmenu.sh "Choose a device name to mount onto $MOUNT_POINT")
  echo -e "$CORRECT_DEVICES" | grep -w "$DEVICE" &> /dev/null
}

function create_datafiles {
  echo "Creating datafiles..."
}

function sync {
  echo -e "\nDo not change backup files during transfer.\n"
  sleep 1
  echo Backing up "$BACKUP_CONTENTS" to "$MOUNT_POINT"
  sudo rsync -aAXvP --delete "$BACKUP_CONTENTS" "$MOUNT_POINT" # what -> where
}

function mount_device {
  sudo mount $(echo "/dev/$DEVICE") "$MOUNT_POINT"
}

function main {
  LS=$(list_devices)
  echo -e "$LS" | grep "$MOUNT_POINT" &> /dev/null
  if [ $? == 0 ]; then
    list_devices
    echo -e -n "\nThere's already something mounted onto $MOUNT_POINT. Unmount? [y/N]: "
    read ANSWER
    if [ "$ANSWER" == "y" ]; then
      sudo umount "$MOUNT_POINT"
      main
    else
      echo "Aborting."
      exit 1
    fi
  else
    list_devices
    read_device_name
    if [ $? == 0 ]; then
      create_datafiles
      mount_device
      sync
    else
      echo "$DEVICE" is not a correct device. Aborting.
      exit 1
    fi
  fi
}

main

# sudo rsync --dry-run -aAXvP --delete --exclude=/swapfile --exclude=/home/vik/dl/* --exclude=/home/vik/.cache/*  --exclude=/home/vik/repos/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude=/lost+found / "$MOUNT_POINT"
