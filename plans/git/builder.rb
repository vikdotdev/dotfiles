destination = home_file '.gitignore'
contents = render_template '.gitconfig'
ensure_write_file(destination, contents)
