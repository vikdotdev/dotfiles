%w[after_use_ensure_gems_installed after_use_print_ruby_version].each do |file|
  ensure_write_file(home_file(".rvm/hooks/#{file}"), read_file(file))
end

ensure_write_file(home_file('.pryrc'), read_file('.pryrc'))
