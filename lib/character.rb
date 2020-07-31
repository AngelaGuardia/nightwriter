class Character
  attr_reader :symbol,
              :dots

  def initialize(symbol, dots)
    @symbol = symbol
    @dots = dots.split(//)
  end
end
