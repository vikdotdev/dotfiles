#!/bin/bash

PERCENT=$(df -h | grep -E "$1$" | awk '{print $5}')
#df -h | grep -E "$1$" | awk '{print $5}'
echo "${PERCENT:0:-1}"

