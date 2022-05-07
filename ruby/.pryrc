#!/usr/bin/env ruby

require 'tty-prompt'

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

Pry.commands.block_command('toggle-color', "toggle colors") do
  pry_instance.config.color = !pry_instance.config.color
end

Pry::Commands.command /^$/, "repeat last command" do
  last_command = Pry.history.to_a.last
  prompt = TTY::Prompt.new
  run = prompt.yes?("Run last command ? - '#{last_command}'")
  if run
    puts
    pry_instance.input = StringIO.new(last_command)
  end
end

Pry.commands.alias_command 'skip-breakpoints', 'exit-program'

Pry::Commands.command /hg/, "find command from history" do
  prompt = TTY::Prompt.new
  selected = prompt.select('>', Pry.history.to_a, filter: true, per_page: TTY::Screen.height - 2)
  pry_instance.input = StringIO.new(selected) unless selected.empty?
rescue Interrupt
  puts
end

Pry::Commands.command 'toggle-pager', "toggle pager" do
  pry_instance.config.pager = !pry_instance.config.pager
end
