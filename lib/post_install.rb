require 'tty-prompt'

class PostInstall
  extend VimHelper

  def self.run
    system('gh auth login')

    if File.directory?(File.join(Dir.home, 'notes'))
      puts '"notes" repo exists. Skipping'
    else
      system('git clone https://github.com/vikdotdev/notes "$HOME/notes"')
    end

    vim_install_plugins

    puts
    puts <<~EOS
      ======================================================
      Done! Check neovim :checkhealth as a precaution!
      ======================================================
    EOS
  rescue Interrupt
  end
end
