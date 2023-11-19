firefox_config_dir = File.join(Dir.home, ".mozilla/firefox/")
firefox_installs_config = File.join(firefox_config_dir, "installs.ini")

def firefox_profile_name(config_path)
  file_content = File.read(config_path)
  default_line = file_content.match(/^Default=(.*)/)

  if default_line
    default_line.captures.first
  else
    puts "Failed to find firefox profile path."
    nil
  end
end

if File.exist?(firefox_installs_config)
  if (profile_name = firefox_profile_name(firefox_installs_config))
    ensure_write_file(
      File.join(home_file(".mozilla/firefox/"), profile_name, 'user.js'),
      read_file('user.js')
    )

    ensure_write_file(
      File.join(home_file(".mozilla/firefox/"), profile_name, 'chrome/userChrome.css'),
      read_file('userChrome.css')
    )
  end
end
