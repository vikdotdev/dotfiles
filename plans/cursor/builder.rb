absolute_file_path = home_file(".local/share/applications/cursor-editor.desktop")
ensure_write_file(absolute_file_path, read_file("cursor-editor.desktop"))

absolute_file_path = home_file(".local/share/icons/cursor-editor.png")
ensure_write_file(absolute_file_path, read_file("cursor-editor.png"))
