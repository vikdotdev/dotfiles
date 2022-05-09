require 'yaml'

class Profile
  attr_reader :number

  def initialize
    profile_config = YAML.load_file(File.join(__dir__, '..', 'config', 'profiles.yml'))

    @number = profile_config[hostname] || 1
  end

  def first?
    @number == 1
  end

  def second?
    @number == 2
  end

  private

  def hostname
    ENV['HOSTNAME']
  end
end

