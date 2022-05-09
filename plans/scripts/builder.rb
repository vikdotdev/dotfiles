files.each do |file|
  absolute_file_path = home_file("bin/#{file}")
  ensure_write_file(absolute_file_path, read_file(file))
  chmod('+x', absolute_file_path)
end
