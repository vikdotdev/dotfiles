require_relative 'tmux_helper'

module VimHelper
  extend TmuxHelper

  def vim_switch_theme(theme)
    lua_cmd = ":lua require('util').set_theme('#{theme}')"

    tmux_sessions.each do |session|
      tmux_windows(session).each do |window|
        tmux_panes(session, window).each do |pane_tty, pane|
          next unless tmux_pane_matches?(pane_tty, 'nvim')

          tmux_send_keys(lua_cmd, session: session, window: window, pane: pane)
        end
      end
    end

    File.open(File.join(Dir.home, '.config', 'dot', 'theme'), 'w+') do |file|
      file.write(theme)
    end
  end

  def vim_install_plugins
    puts 'Initializing neovim plugins'
    cmd = "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2> /dev/null"

    system(cmd, out: File::NULL)

    puts 'Installing tree-sitter. This will take a while ...'
    cmd = "nvim --headless -c 'silent TSInstall all' -c 'sleep 180' -c 'qa'"

    system(cmd, out: File::NULL)
  end
end


