#!/bin/bash
# obsolete, xkb-switch does it's job

langcode=$(xset -q | grep -A 0 'LED' | cut -c59-67)

case $langcode in
  00001000) echo "uk" && exit 0 ;;
  00000000) echo "en" && exit 0 ;;
esac
