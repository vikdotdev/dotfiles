class Theme
  WHITELIST = %i[dark light]
  DEFAULT = :dark

  attr_reader :type

  def initialize(type = nil)
    @type = type&.to_sym || persisted_theme || DEFAULT
    raise 'Invalid theme type' unless WHITELIST.include? @type
  end

  def dark?
    type.to_sym == :dark
  end

  def light?
    type.to_sym == :light
  end

  private

  def persisted_theme
    theme = File.read(File.join(Dir.home, '.config', 'dot', 'theme')).chomp.to_sym

    theme if WHITELIST.include?(theme)
  rescue
    nil
  end
end
