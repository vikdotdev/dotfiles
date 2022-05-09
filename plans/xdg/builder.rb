files.each do |file|
  ensure_write_file(home_file(".config/#{file}"), read_file(file))
end

%w[
  books
  dls
  docs
  pics/wallpapers
  vids
  .local/share/.xdg-hidden/desktop
  .local/share/.xdg-hidden/music
  .local/share/.xdg-hidden/public
  .local/share/.xdg-hidden/templates
].map { |path| FileUtils.mkdir_p(home_file(path)) }
