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
    turn_on_dots unless dot_nums == "0"
  end

  def create_dots
    6.times do |i|
      @dots[(i+1).to_s] = Dot.new(i.to_s)
    end
  end

  def turn_on_dots
    dot_nums.each { |num| @dots[num].turn_on }
  end

  def render_row(num)
    if num == 1
      "#{@dots["1"].render}#{@dots["4"].render}"
    elsif num == 2
      "#{@dots["2"].render}#{@dots["5"].render}"
    elsif num == 3
      "#{@dots["3"].render}#{@dots["6"].render}"
    end
  end
end
