# TODO: DEPRECATED
# destination = home_file '.config/alacritty/alacritty.yml'
# contents = render_template 'alacritty.yml'

destination = home_file '.config/alacritty/alacritty.toml'
contents = render_template 'alacritty.toml'
ensure_write_file(destination, contents)
