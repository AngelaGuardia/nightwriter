require './lib/dot'

class Character
  attr_reader :symbol,
              :dot_nums,
              :dots

  def initialize(symbol, dot_nums)
    @symbol = symbol
    @dot_nums = dot_nums.split(//)
    @dots = []
    create_dots
  end

  def create_dots
    6.times do |i|
      @dots << Dot.new(i.to_s)
    end
  end
end
