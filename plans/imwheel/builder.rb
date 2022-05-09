ensure_write_file(home_file('.imwheelrc'), read_file('.imwheelrc'))
ensure_write_file(home_file('.config/systemd/user/imwheel.service'), read_file('imwheel.service'))
ensure_service_running('imwheel.service')
