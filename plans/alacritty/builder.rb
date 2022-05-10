destination = home_file '.config/alacritty/alacritty.yml'
contents = render_template 'alacritty.yml'
ensure_write_file(destination, contents)
