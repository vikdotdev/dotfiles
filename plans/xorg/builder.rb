templates.each do |template|
  destination = home_file(template)
  contents = render_template(template)
  ensure_write_file(destination, contents)
end

ensure_write_file(home_file('.config/systemd/user/xsecurelock.service'),
                  read_file('xsecurelock.service'))
ensure_service_running('xsecurelock.service')

system('xrdb ~/.Xresources 2> /dev/null')
