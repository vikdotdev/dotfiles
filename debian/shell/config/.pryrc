ENV['PAGER'] = ENV['EDITOR']
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
Pry.commands.alias_command 'fm', 'find-method'
Pry.commands.alias_command 'dp', 'disable-pry'
