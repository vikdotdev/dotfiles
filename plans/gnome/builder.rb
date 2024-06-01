system("dconf load / < #{file_path('dconf.ini')}")

ensure_write_file(home_file('.config/gtk-3.0/gtk.css'), read_file('gtk3.css'))
ensure_write_file(home_file('.config/gtk-3.0/settings.ini'), read_file('settings3.ini'))

ensure_write_file(home_file('.config/gtk-4.0/gtk.css'), read_file('gtk4.css'))
