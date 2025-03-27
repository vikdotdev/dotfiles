files.each do |file|
  absolute_file_path = home_file(".gnupg/#{file}")
  ensure_write_file(absolute_file_path, read_file(file))
end
