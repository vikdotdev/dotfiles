require 'yaml'

class Profile
  attr_reader :number, :config

  def initialize
    @config = YAML.load_file(File.join(__dir__, '..', 'config.yml'))['profile']

    @number = @config[hostname] || 1
  end

  def in?(*args)
    args.include?(@number)
  end

  def hostname
    ENV['HOSTNAME']
  end
end

