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

  def render
    line = ""
    3.times do |i|
      row = i + 1
      @characters.each do |character|
        line += character.render_row(row)
        line += "\n" if @characters.last == character && row != 3
      end
    end
    line
  end
end
