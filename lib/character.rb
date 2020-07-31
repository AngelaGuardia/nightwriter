require './lib/dot'

class Character
  attr_reader :symbol,
              :dot_nums,
              :dots

  def initialize(symbol, dot_nums)
    @symbol = symbol
    @dot_nums = dot_nums.split(//)
    @dots = {}
    create_dots
    turn_on_dots
  end

  def create_dots
    6.times do |i|
      @dots[(i+1).to_s] = Dot.new(i.to_s)
    end
  end

  def turn_on_dots
    dot_nums.each { |num| @dots[num].turn_on }
  end
end
