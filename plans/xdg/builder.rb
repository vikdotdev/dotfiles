files.each do |file|
  ensure_write_file(home_file(".config/#{file}"), read_file(file))
end

def xdg_user_dir(name)
  `xdg-user-dir #{name}`.chomp
end

xdg_dir_map = {
  "Templates" => xdg_user_dir("TEMPLATES")
}

ext_xdg_dirs = %w[
  Repositories
  Documents/books
  Documents/notes
  Pictures/wallpapers
]

[
  *ext_xdg_dirs,
  *xdg_dir_map.values
].map { |path| FileUtils.mkdir_p(path) }

xdg_dir_map.each_key do |path|
  next unless File.exist?(home_file(path))

  Dir.glob("#{home_file(path)}/*").each do |file|
    dest = File.join(xdg_dir_map[path], file.delete_prefix(home_file(path)))
    puts "Moving #{file} to #{dest}"
    FileUtils.mv(file, dest)
  end
end

xdg_dir_map.keys.map do |path|
  next unless File.exist?(home_file(path))

  FileUtils.rmdir(home_file(path))
end
