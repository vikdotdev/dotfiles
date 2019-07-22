#!/bin/bash

MOUNT_POINT="/mnt/backup"
BACKUP_CONTENTS="/home/vik/" # note the trailing space here
LS=$(lsblk -l | awk '{print $1,$4,$7}' | grep 'sd[a-z][0-9]')
CORRECT_DEVICES=$(lsblk -l | awk '{print $1}' | grep 'sd[a-z][0-9]')
DEVICE=

function list_devices {
  echo "DEV SIZE MOUNTED"
  echo "$LS"
}

function read_device_name {
  echo -e -n "\nChoose a device name to mount onto "$MOUNT_POINT": "
  read DEVICE
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
  echo "$LS" | grep "$MOUNT_POINT" &> /dev/null
  if [ $? == 0 ]; then
    echo -e "\nThere's already something mounted onto $MOUNT_POINT. Unmount it manually and try again.\n"
    list_devices
    exit 1
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
