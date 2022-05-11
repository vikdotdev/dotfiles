require_relative 'tmux_helper'

module VimHelper
  extend TmuxHelper

  def vim_switch_theme(theme)
    lua_cmd = ":lua require('github-theme').setup({ theme_style = '#{theme}' })"

    tmux_sessions.each do |session|
      tmux_windows(session).each do |window|
        tmux_panes(session, window).each do |pane_tty, pane|
          next unless tmux_pane_vim?(pane_tty)

          tmux_send_keys(lua_cmd, session: session, window: window, pane: pane)

          File.open(File.join(Dir.home, '.config', 'nvim', 'theme'), 'w+') do |file|
            file.write(theme)
          end
        end
      end
    end
  end
end


