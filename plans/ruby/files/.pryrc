#!/usr/bin/env ruby

# Prints current scope variables on breakpoint.
class ScopePrinter
  attr_reader :binding, :pry

  def initialize(binding, pry)
    @binding = binding
    @pry = pry
  end

  def call
    return if binding.eval('self.class') == Object

    print(_instance_variables, color: :red)
    print(_local_variables, color: :cyan)
  end

  private

  def _instance_variables
    binding.eval('instance_variables').reject { |name| name.to_s.start_with?('@_') }.sort
  end

  def _local_variables
    binding.eval('local_variables').reject { |name| name.to_s.start_with?('_') }.sort
  end

  def print(variables, color: 'white')
    variables.each do |name|
      puts <<~LINE.split.join(' ').then(&method(:truncate))
        #{colorize(color, name)}
        =>
        #{binding.eval(name.to_s).inspect}
      LINE
    end
  end

  def truncate(text)
    text[0...256]
  end

  def colorize(name, text)
    Pry::Helpers::Text.public_send(name.to_s, text)
  end
end

Pry.hooks.add_hook(:before_session, "pry_state_hook") do |_output, _binding, _pry|
  ScopePrinter.new(_binding, _pry).call
end

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
Pry.commands.alias_command 'fm', 'find-method'
Pry.commands.alias_command 'fm', 'find-method'
Pry.commands.alias_command 'dp', 'disable-pry'

# Repeats last command when pressing a Return key
# Pry::Commands.command /^$/, 'repeat last command' do
#   last_command = Pry.history.to_a.last
#   pry_instance.input = StringIO.new(last_command)
# end

Pry::Commands.command 'toggle-pager', "toggle pager" do
  pry_instance.config.pager = !pry_instance.config.pager
end
