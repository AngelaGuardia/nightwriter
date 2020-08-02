require './lib/dictionary'

class NightReader
  attr_reader :braille_filename,
              :translated_filename,
              :translated_file

  def initialize
    @braille_filename = ARGV[0]
    @translated_filename = ARGV[1]
  end

  def read
    @braille_file = File.read(@braille_filename).chomp
  end

  def write
    File.open(@translated_filename, "w") { |f| f.write(translate_braille) }
    @translated_file = File.read(@translated_filename)
  end

  def confirmation_message
    "Created '#{@translated_filename}' containing #{translated_file.length} characters"
  end

  def translate_braille
    translator = Dictionary.new(true)
    braille_rows = @braille_file.split("\n")
    translation = ""
    row1, row2, row3 = [], [], []
    while !braille_rows.empty?
      braille_line = braille_rows.slice!(0, 3)
      braille_line.each_with_index do |row, index|
        character_pairs = row.scan(/.{2}/)
        if index == 0
          row1 = braille_nums_row1(character_pairs)
        elsif index == 1
          row2 = braille_nums_row2(character_pairs)
        else
          row3 = braille_nums_row3(character_pairs)
        end
      end

      braille_nums_by_character = row1.zip(row2, row3)

      braille_nums_by_character_sorted = braille_nums_by_character.map do |nums|
        if nums.join == ""
          "0"
        else
          nums.join.split(//).sort.join
        end
      end

      translated_characters = braille_nums_by_character_sorted.map { |nums| translator.get(nums)}
      translation += translated_characters.join
    end
    translation
  end

  def braille_nums_row1(row)
    row.map do |chars|
      new = ""
      new += "1" if chars[0] == "0"
      new += "4" if chars[1] == "0"
      new
    end
  end

  def braille_nums_row2(row)
    row.map do |chars|
      new = ""
      new += "2" if chars[0] == "0"
      new += "5" if chars[1] == "0"
      new
    end
  end

  def braille_nums_row3(row)
    row.map do |chars|
      new = ""
      new += "3" if chars[0] == "0"
      new += "6" if chars[1] == "0"
      new
    end
  end
end
