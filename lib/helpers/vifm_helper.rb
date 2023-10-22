require_relative 'tmux_helper'

module VifmHelper
  extend TmuxHelper

  def vifm_switch_theme(theme)
    cmd = ":colorscheme #{theme}"

    tmux_sessions.each do |session|
      tmux_windows(session).each do |window|
        tmux_panes(session, window).each do |pane_tty, pane|
          next unless tmux_pane_matches?(pane_tty, 'vifm')

          tmux_send_keys(cmd, session: session, window: window, pane: pane)
        end
      end
    end

    File.open(File.join(Dir.home, '.config', 'dot', 'theme'), 'w+') do |file|
      file.write(theme)
    end
  end
end

