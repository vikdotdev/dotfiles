#!/bin/bash
langcode=$(xset -q | grep -A 0 'LED' | cut -c59-67)

case $langcode in
  00001000) echo "ua" ;;
  00000000) echo "eng" ;;
esac
