class Color
  class ColorNotFound < StandardError; end

  attr_reader :config

  def initialize(config)
    @config = config
  end

  def dark(variant, name, hex: true)
    dig!('palette', 'dark', variant.to_s, name.to_s, hex ? 'hex' : 'term')
    # config.dig('palette', 'dark', variant.to_s, name.to_s)
  end

  def light(variant, name, hex: true)
    dig!('palette', 'light', variant.to_s, name.to_s, hex ? 'hex' : 'term')
    # config.dig('palette', 'light', variant.to_s, name.to_s)
  end

  def mono(number, hex: true)
    dig!('palette', 'monochrome', "gray_#{number}", hex ? 'hex' : 'term')
    # config.dig('palette', 'monochrome', "gray_#{number}")
  end

  private

  def dig!(*args)
    value = config.dig(*args)
    raise ColorNotFound, args.inspect if value.nil?

    value
  end
end
