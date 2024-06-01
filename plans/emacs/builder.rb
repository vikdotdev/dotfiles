files(subpath: "doom").each do |file|
  ensure_write_file(home_file(".config/doom/#{file}"), read_file("doom/#{file}"))
end
