files.each do |file|
  absolute_file_path = home_file("bin/#{file}")
  ensure_write_file(absolute_file_path, read_file(file))
  chmod('+x', absolute_file_path)
end

templates.each do |template|
  absolute_file_path = home_file("bin/#{template}")
  ensure_write_file(absolute_file_path, render_template(template))
  chmod('+x', absolute_file_path)
end
