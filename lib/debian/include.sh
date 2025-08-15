#!/bin/bash

# Get the debian lib directory path
DEBIAN_LIB_DIR="$(dirname "${BASH_SOURCE[0]}")"
LIB_DIR="$(dirname "$DEBIAN_LIB_DIR")"

source "$LIB_DIR/colors.sh"
source "$LIB_DIR/logging.sh"
source "$LIB_DIR/constants.sh"
source "$LIB_DIR/utils.sh"

# May override some functions
source "$DEBIAN_LIB_DIR/constants.sh"
source "$DEBIAN_LIB_DIR/utils.sh"
