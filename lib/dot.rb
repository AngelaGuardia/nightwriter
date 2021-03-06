class Dot
  attr_reader :number

  def initialize(number)
    @number = number
    @is_on = false
  end

  def turn_on
    @is_on = true
  end

  def on?
    @is_on
  end

  def render
    if on?
      "0"
    else
      "."
    end
  end
end
