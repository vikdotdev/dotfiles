files(recursive: true).each do |file|
  destination = home_file(file)
  contents = read_file(file)
  ensure_write_file(destination, contents)
end

vim_switch_theme(@theme.type)
