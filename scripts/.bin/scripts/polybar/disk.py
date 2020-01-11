#!/usr/bin/env python3
# add arguments as [ --display percent | symbol ], --target to get capacity

from polybarconfig import get_symbol, color_foreground, color_background, COLOR_MAP, SYMBOL_MAP

def get_label(mount_point):
    variants = {
            '/': 'root',
            'home': 'home',
            '/home': 'home',
            }
    return variants[mount_point]

def main(ramp_value):
    symbol = str(get_symbol(ramp_value))
    label = get_label('/') + ' '
    good = COLOR_MAP['good']
    warning = COLOR_MAP['background-alt']
    danger = COLOR_MAP['danger']
    colored_symbol = color_foreground(good, symbol)
    colored_label = color_foreground(warning, label)
    return colored_label + colored_symbol



print(main(95))


