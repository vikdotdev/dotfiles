destination = home_file '.config/zathura/zathurarc'
contents = render_template 'zathurarc'
ensure_write_file(destination, contents)
