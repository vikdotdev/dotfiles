destination = home_file '.gitconfig'
contents = render_template '.gitconfig'
ensure_write_file(destination, contents)
