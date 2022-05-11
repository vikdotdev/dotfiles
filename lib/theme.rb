class Theme
  WHITELIST = %i[dark light]
  DEFAULT = :dark

  attr_reader :type

  def initialize(type = nil)
    # TODO read current theme instead
    @type = type&.to_sym || DEFAULT
    raise 'Invalid theme type' unless WHITELIST.include? @type
  end

  def dark?
    type.to_sym == :dark
  end

  def light?
    type.to_sym == :light
  end
end
