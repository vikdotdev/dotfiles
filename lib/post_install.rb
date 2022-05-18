require 'tty-prompt'

class PostInstall
  extend VimHelper

  def self.run
    system('gh auth login')
    system('git clone https://github.com/vikdotdev/notes "$HOME/notes"')

    vim_install_plugins

    puts <<~EOS
      Done!
      Don't forget to run TSInstall all in neovim (<Leader>mi).
    EOS
  end
end
