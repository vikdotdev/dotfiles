ensure_write_file(home_file('.tmux.conf.local'), render_template('.tmux.conf.local'))
ensure_write_file(home_file('.config/tmuxinator/home.yml'), read_file('home.yml'))
tmux_reload(home_file('.tmux.conf'))
