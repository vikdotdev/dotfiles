# fixes inf-ruby#send
Pry.commands.delete /\.(.*)/

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry.commands.alias_command 'q', 'exit'
  Pry.commands.alias_command 'r', 'reload!'
end

# Hit Enter to repeat last command
Pry::Commands.command /^$/, "repeat last command" do
  pry_instance.run_command Pry.history.to_a.last
end

# does not work
# Pry.commands.block_command(/page-off/, "Disable pager.") do
#   puts 'Disabling pager'
#   Pry.config.pager = false
# end

# Pry.commands.block_command(/page-on/, "Enable pager.") do
#   puts 'Enabling pager'
#   Pry.config.pager = true
# end

if ENV['INSIDE_EMACS']
  Pry.config.correct_indent = false
  Pry.config.pager = false
end

Pry.config.editor = ENV['EDITOR']
