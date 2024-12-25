files.each do |file|
  ensure_write_file(home_file(".config/emacs/#{file}"), read_file(file))
end

absolute_file_path = home_file(".emacs-profiles.el")
ensure_write_file(absolute_file_path, read_file(".emacs-profiles.el"))
