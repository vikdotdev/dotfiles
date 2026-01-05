#!/bin/bash

# Get the macos lib directory path
MACOS_LIB_DIR="$(dirname "${BASH_SOURCE[0]}")"
LIB_DIR="$(dirname "$MACOS_LIB_DIR")"

source "$LIB_DIR/colors.sh"
source "$LIB_DIR/logging.sh"
source "$LIB_DIR/constants.sh"
source "$LIB_DIR/utils.sh"

# May override some functions
source "$MACOS_LIB_DIR/utils.sh"
source "$MACOS_LIB_DIR/constants.sh"
