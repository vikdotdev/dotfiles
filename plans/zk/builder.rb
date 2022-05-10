destination = home_file '.config/zk/config.toml'
contents = read_file 'config.toml'
ensure_write_file(destination, contents)
