require './lib/dictionary'

class NightReader
  attr_reader :braille_filename,
              :translated_filename,
              :translated_file

  def initialize
    @braille_filename = ARGV[0]
    @translated_filename = ARGV[1]
    read
    write
  end

  def read
    @braille_file = File.read(@braille_filename).chomp
  end

  def write
    File.open(@translated_filename, "w") { |f| f.write(translate_braille) }
    @translated_file = File.read(@translated_filename)
    puts confirmation_message
  end

  def confirmation_message
    "Created '#{@translated_filename}' containing #{translated_file.length} characters"
  end

  def translate_braille
    translator = Dictionary.new(true)
    braille_rows = @braille_file.split("\n")
    translation = ""
    while !braille_rows.empty?
      braille_line = braille_rows.slice!(0, 3)
      braille_nums_by_line = braille_line_to_braille_nums(braille_line)
      braille_nums_by_character = braille_nums_by_line[0].zip(braille_nums_by_line[1], braille_nums_by_line[2])
      braille_nums_by_character_sorted = join_and_sort_braille_nums_by_character(braille_nums_by_character)
      translated_characters = braille_nums_by_character_sorted.map { |nums| translator.get(nums)}
      translation += translated_characters.join
    end
    translation
  end

  def braille_line_to_braille_nums(braille_line)
    braille_line.map do |row|
      character_pairs = row.scan(/.{2}/)
      if row == braille_line.first
        braille_nums_row1(character_pairs)
      elsif row == braille_line.last
        braille_nums_row3(character_pairs)
      else
        braille_nums_row2(character_pairs)
      end
    end
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

  def join_and_sort_braille_nums_by_character(braille_nums_by_character)
    braille_nums_by_character.map do |nums|
      if nums.join == ""
        "0"
      else
        nums.join.split(//).sort.join
      end
    end
  end
end

NightReader.new
