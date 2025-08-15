#!/bin/bash

# Get the lib directory path
LIB_DIR="$(dirname "$(dirname "${BASH_SOURCE[0]}")")"

# Source general constants first
source "$LIB_DIR/constants.sh"

DEBIAN_VERSION=$(cat /etc/debian_version 2>/dev/null || echo "unknown")
DEBIAN_CODENAME=$(lsb_release -cs 2>/dev/null || echo "unknown")

