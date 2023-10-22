ensure_write_file(home_file('.config/vifm/vifmrc'), read_file('vifmrc.erb'))

ensure_write_file(home_file('.config/vifm/colors/dark.vifm'), read_file('dark.vifm.erb'))
ensure_write_file(home_file('.config/vifm/colors/light.vifm'), read_file('light.vifm.erb'))
