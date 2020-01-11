#!/bin/bash
# Still needs work - won't preserve it's width if cpu load is 100%

cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{printf "%02d", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}'
