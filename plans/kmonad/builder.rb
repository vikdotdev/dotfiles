# cmp-seq ralt breaks diactrics composition
if @profile.second?
  template_name = 'thinkpad-t460.kbd'
  ensure_write_file(home_file(".config/kmonad/#{template_name}"), render_template(template_name))
end

if @profile.third?
  template_name = 'thinkpad-p15v.kbd'
  ensure_write_file(home_file(".config/kmonad/#{template_name}"), render_template(template_name))
end

if @profile.second? || @profile.third?
  template_name = 'kmonad.service'
  ensure_write_file(home_file(".config/systemd/user/#{template_name}"), render_template(template_name))
  ensure_service_running(template_name)

  @kmonad_alias = render_template('kmonad-alias.kbd')
end

def notify_command(text)
  <<~CMD
    "$HOME/bin/util-awesome-notify -t Kmonad -b \"#{text}\""
  CMD
end

@number_layer_enabled_cmd = notify_command "Number layer - ON"
@number_layer_disabled_cmd = notify_command "Number layer - OFF"
