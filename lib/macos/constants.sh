#!/bin/bash

# Get the lib directory path
LIB_DIR="$(dirname "$(dirname "${BASH_SOURCE[0]}")")"

# Source general constants first
source "$LIB_DIR/constants.sh"

MACOS_VERSION=$(sw_vers -productVersion 2>/dev/null || echo "unknown")
MACOS_CODENAME=$(get_macos_codename 2>/dev/null || echo "unknown")
