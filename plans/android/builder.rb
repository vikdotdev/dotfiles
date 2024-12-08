@android_installation_path = ENV["ANDROID_INSTALLATION"] || "/home/vik/.local/share/Google/android-studio"

raise "Android installation path not found" if @android_installation_path.nil?

absolute_file_path = home_file(".local/share/applications/android-studio.desktop")
ensure_write_file(absolute_file_path, read_file("android-studio.desktop"))
