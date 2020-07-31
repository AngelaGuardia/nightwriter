class Line
  attr_reader :characters
  
  def initialize
    @characters = []
  end

  def add_character(character)
    @characters << character
  end

end