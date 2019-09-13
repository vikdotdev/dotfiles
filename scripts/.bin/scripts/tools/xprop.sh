#!/bin/bash
# alternatively make this work with notification

echo $(xprop | grep -E '^WM_NAME' | awk '{print $3}')
