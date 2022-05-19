%w[after_use_ensure_gems_installed after_use_print_ruby_version].each do |file|
  absolute_file_path = home_file(".rvm/hooks/#{file}")
  ensure_write_file(absolute_file_path, read_file(file))
  chmod('+x', absolute_file_path)
end

ensure_write_file(home_file('.pryrc'), read_file('.pryrc'))
