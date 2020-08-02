require 'csv'

class Dictionary
  attr_reader :dictionary

  def initialize(translator_mode = false)
    @dictionary = {}
    @mode = translator_mode
    if translator_mode
      generate_translator
    else
      generate
    end
  end

  def generate
    CSV.foreach('./data/braille_dots.csv', headers: true, header_converters: :symbol) do |row|
      @dictionary[row[:character]] = row[:nums]
    end
  end

  def generate_translator
    CSV.foreach('./data/braille_dots.csv', headers: true, header_converters: :symbol) do |row|
      @dictionary[row[:nums]] = row[:character]
    end
  end

  def get(value)
    @dictionary[value]
  end
end
