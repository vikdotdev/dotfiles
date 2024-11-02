files(subpath: "doom").each do |file|
  ensure_write_file(home_file(".config/doom/#{file}"), read_file("doom/#{file}"))
end

files(subpath: "my").each do |file|
  ensure_write_file(home_file(".config/myemacs/#{file}"), read_file("my/#{file}"))
end

absolute_file_path = home_file(".emacs-profiles.el")
ensure_write_file(absolute_file_path, read_file(".emacs-profiles.el"))

absolute_file_path = home_file(".local/share/applications/myemacs.desktop")
ensure_write_file(absolute_file_path, read_file("myemacs.desktop"))
