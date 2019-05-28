#!/bin/bash

df -h | grep -E "$1$" | awk '{print $3 "/" $2}'

