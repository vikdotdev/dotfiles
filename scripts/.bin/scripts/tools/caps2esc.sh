#!/bin/bash

function start {
  echo Starting udevmon.service
  sudo systemctl start udevmon.service
}

function stop {
  echo Stopping udevmon.service
  sudo systemctl stop udevmon.service
}

function main {
  if [ -x "$(command -v caps2esc)" ]; then
    echo caps2esc found
    systemctl is-active --quiet udevmon
    if [ "$?" == 0 ]; then
      stop
    else
      start
    fi
  else
    echo caps2esc not found. Aborting.
  fi
}

main
