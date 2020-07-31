require './lib/character'
require './lib/dictionary'

class Line
  attr_reader :characters

  def initialize
    @characters = []
    @dictionary = Dictionary.new
  end

  def add_character(character)
    @characters << character
  end

  def length
    @characters.size
  end

  def generate_characters(symbols)
    symbols.each do |symbol|
      add_character(Character.new(symbol, @dictionary.get(symbol)))
    end
  end
end
