class Theme
  WHITELIST = %i[dark light]

  attr_reader :type

  def initialize(type = :dark)
    @type = type.to_sym
    raise 'Invalid theme type' unless WHITELIST.include? @type
  end

  def dark?
    type.to_sym == :dark
  end

  def light?
    type.to_sym == :light
  end

  def changed?
    true
    # read file and compare to type
    # Is this needed?
    # maybe check if generated templates changed overall or not? global method
  end
end
