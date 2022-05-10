if @profile.second?
  ensure_write_file(home_file('.config/kmonad/laptop.kbd'), read_file('laptop.kbd'))

  ensure_write_file(home_file('.config/systemd/user/kmonad.service'), read_file('kmonad.service'))
  ensure_service_running('kmonad.service')
end
