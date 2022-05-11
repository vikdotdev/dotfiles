ensure_write_file(home_file('.config/dot/theme'), read_file('theme'))

vim_switch_theme(@theme.type)
