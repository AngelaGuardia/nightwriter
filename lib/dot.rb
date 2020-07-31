class Dot
  attr_reader :number,
              :is_on

  def initialize(number)
    @number = number
    @is_on = false
  end

  def turn_on
    @is_on = true
  end
end
