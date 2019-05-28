#!/bin/sh
# Replace echo with notifier
transmission-remote -a "$@" && echo 'torrent added'
