require 'csv'

class Dictionary
  attr_reader :dictionary

  def initialize
    @dictionary = {}
    generate
  end

  def generate
    CSV.foreach('./data/braille_dots.csv', headers: true, header_converters: :symbol) do |row|
      @dictionary[row[:character]] = row[:nums]
    end
  end
end
