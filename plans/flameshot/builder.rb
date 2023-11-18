destination = home_file '.config/flameshot/flameshot.ini'
contents = render_template 'flameshot.ini'
ensure_write_file(destination, contents)
