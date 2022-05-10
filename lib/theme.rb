class Theme
  WHITELIST = %i[dark white]

  attr_reader :type

  def initialize(type = :dark)
    @type = type
    raise 'Invalid theme type' unless WHITELIST.include? type
  end

  def dark?
    type.to_sym == :dark
  end

  def light?
    type.to_sym == :light
  end
end
