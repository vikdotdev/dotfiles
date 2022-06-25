ensure_write_file(
  home_file('.config/autostart/autostart.desktop'),
  render_template('autostart.desktop')
)
