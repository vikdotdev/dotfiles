#!/bin/bash

MOUNT_POINT="/mnt/backup/" # note the trailing space here
BACKUP_CONTENTS="/home/$USER"
LS=$(lsblk -l | awk '{print $1,$4,$7}' | grep 'sd[b-z][0-9]')
CORRECT_DEVICES=$(lsblk -l | awk '{print $1}' | grep 'sd[b-z][0-9]')
DEVICE=

function list_devices {
  echo "DEV  SIZE  MOUNTED"
  local LIST=$(lsblk -l | awk '{print $1,$4,$7}' | grep 'sd[b-z][0-9]')
  echo "$LIST"
}

function read_device_name {
  local PROMPT="Choose a device name to mount onto $MOUNT_POINT"
  if [ -x "$(command -v rofi)" ]; then
    DEVICE=$(echo "$CORRECT_DEVICES" | rofi_dmenu.sh "$PROMPT")
  else
    echo -e -n "\n$PROMPT: "
    read DEVICE
  fi
  echo -e "$CORRECT_DEVICES" | grep -w "$DEVICE" &> /dev/null
}

function create_datafiles {
  echo "Saving pacman package list"
  local BACKUPDIR="/home/$USER/backup/"
  mkdir "$BACKUPDIR" &> /dev/null
  comm -23 <(pacman -Qqe | sort) <(pacman -Qqg base -g base-devel | sort | uniq) | less > "$BACKUPDIR"/packages-$(date +%F)
}

function sync {
  echo -e "Do not change backup files during transfer.\n"
  sleep 1
  echo Backing up "$BACKUP_CONTENTS" to "$MOUNT_POINT"
  sudo rsync -aAXvP --delete --exclude=/vik/repos/*/node_modules --exclude=/vik/.npm --exclude=/vik/.config/chromium --exclude=/vik/dl/* --exclude=/vik/temp/* --exclude=/vik/.cache/* "$BACKUP_CONTENTS" "$MOUNT_POINT" # what -> where
}

function mount_device {
  echo "Mounting $DEVICE"
  sudo mount $(echo "/dev/$DEVICE") "$MOUNT_POINT"
}

function umount_device {
  echo "Unmounting $MOUNT_POINT"
  sudo umount "$MOUNT_POINT"
}

function main {
  LS=$(list_devices)
  echo -e "$LS" | grep "${MOUNT_POINT::-1}" &> /dev/null
  if [ $? == 0 ]; then
    list_devices
    echo -e -n "\nThere's already something mounted onto $MOUNT_POINT. Unmount? [y/N]: "
    read ANSWER
    if [ "$ANSWER" == "y" ]; then
      umount_device
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
      umount_device
    else
      echo "$DEVICE" is not a correct device. Aborting.
      exit 1
    fi
  fi
}

main

# sudo rsync --dry-run -aAXvP --delete --exclude=/swapfile --exclude=/home/vik/dl/* --exclude=/home/vik/.cache/*  --exclude=/home/vik/repos/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude=/lost+found / "$MOUNT_POINT"
