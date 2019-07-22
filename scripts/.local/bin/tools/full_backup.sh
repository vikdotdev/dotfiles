#!/bin/bash
MOUNT_POINT="/mnt/backup"
LS=$(lsblk -l | awk '{print $1,$4,$7}' | grep 'sd[a-z][0-9]')
CORRECT_DEVICES=$(lsblk -l | awk '{print $1}' | grep 'sd[a-z][0-9]')
DEVICE=

echo "$LS" | grep "$MOUNT_POINT" &> /dev/null
if [ $? == 0 ]; then
  echo "There's already something mounted onto $MOUNT_POINT. Run lsblk command, unmount it manually and try again."
  exit 1
else
  echo "DEV SIZE MOUNTED"
  echo "$LS"
  echo -e -n "\nChoose a drive name from list to mount onto "$MOUNT_POINT": "
  read DEVICE
  echo -e "$CORRECT_DEVICES" | grep -w "$DEVICE" &> /dev/null
  if [ $? == 0 ]; then
    echo Correct
  else
    echo "$DEVICE" device is incorrect. Aborting.
    exit 2
  fi
fi
# sudo rsync --dry-run -aAXvP --delete --exclude=/swapfile --exclude=/home/vik/dl/* --exclude=/home/vik/.cache/*  --exclude=/home/vik/repos/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude=/lost+found / /mnt/usb1/
