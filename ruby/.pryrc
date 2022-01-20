#!/usr/bin/env ruby

# Leading space is important here to avoid pry regex check
ENV['PAGER'] = ' less --raw-control-chars --mouse --wheel-lines=3 -F -X'

Pry.config.editor = ENV['EDITOR']

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

if defined?(PryRails)
  def r
    reload!
  end
end

Pry.commands.alias_command 'e', 'exit'
Pry.commands.alias_command 'clear', 'clear-screen'
Pry.commands.alias_command 'wai', 'whereami'

Pry::Commands.command /^$/, "Repeat last command with RETURN" do
  pry_instance.run_command Pry.history.to_a.last
end

Pry.commands.block_command('color-toggle', "Toggle colors.") do
  Pry.config.color = !Pry.config.color
end

