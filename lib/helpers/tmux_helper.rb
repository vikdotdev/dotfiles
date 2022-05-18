module TmuxHelper
  def tmux_sessions
    cmd = 'tmux list-sessions -F "#{session_name}"'

    `#{cmd} 2> /dev/null`.each_line.map(&:chomp)
  end

  def tmux_windows(session)
    `tmux list-windows -t #{session}`.each_line.map { |line| line.gsub!(/\A(\d+): .*/, '\1').chomp }
  end

  def tmux_panes(session, window)
    cmd = 'tmux list-panes -F "#{pane_tty}:#{pane_index}"'.concat(" -t #{session}:#{window}")

    `#{cmd}`.each_line.map { |line| line.chomp.split(':') }
  end

  def tmux_pane_vim?(pane_tty)
    system("ps -o state= -o comm= -t #{pane_tty} | grep -iqE '^[^TXZ] nvim'")
  end

  def tmux_send_keys(command, opts = {})
    target = []
    target << "#{opts[:session]}:" if opts[:session]
    target << "#{opts[:window]}."  if opts[:window]
    target << opts[:pane]          if opts[:pane]
    target = target.join('')

    system("tmux send-keys -t #{target} \"#{command}\" Enter")
  end

  def tmux_reload(tmux_conf_path)
    `tmux source-file #{tmux_conf_path}` if File.exists?(tmux_conf_path)
  end
end
