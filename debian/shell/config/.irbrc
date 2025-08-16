ENV['PAGER'] = ENV['EDITOR']

# IRB configuration
IRB.conf[:EDITOR] = ENV['EDITOR']

# Load required gems if available
begin
  require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 100_000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
rescue LoadError
end

# Aliases for common commands
def e
  exit
end

def clear
  system('clear')
end

def r
  reload! if defined?(reload!)
end

# Debug aliases (if byebug/debug is available)
begin
  require 'debug'

  def s
    step
  end
  
  def n
    next
  end
  
  def f
    finish
  end
rescue LoadError
  # Define dummy methods if debug gems not available
  def s; puts "Debug gem not available"; end
  def n; puts "Debug gem not available"; end
  def f; puts "Debug gem not available"; end
end
