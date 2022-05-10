files.each do |file|
  ensure_write_file(home_file(file), read_file(file))
end


ensure_write_file(home_file('.profile'), render_template('.profile'))

