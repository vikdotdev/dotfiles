destination = home_file '.config/zathura/zathurarc'
contents = render_template 'zathurarc'
ensure_write_file(destination, contents)

# themes = config('colors.yml')
# colors = themes[@theme.type]
