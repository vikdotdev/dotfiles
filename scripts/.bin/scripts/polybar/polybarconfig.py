#!/usr/bin/env python3

import configparser

parser = configparser.ConfigParser()
parser.read('/home/vik/.config/polybar/config')
COLOR_MAP = parser._sections['colors']
SYMBOL_MAP = parser._sections['ramp']

def get_symbol(ramp_value):
    out = ''
    for percentage, symbol in SYMBOL_MAP.items():
        if ramp_value >= float(percentage):
            out = symbol
            continue
        else:
            break
    return out

def color_foreground(color, value):
    return '%{F' + color + '}' + value + '%{F-}'

def color_background(color, value):
    return '%{B' + color + '}' + value + '%{B-}'
