require './lib/dictionary'
require './lib/file_io'

class Reader
  include FileIO

  attr_reader :input_filename,
              :output_filename,
              :input_file,
              :output_file

  def initialize
    @input_filename = ARGV[0]
    @output_filename = ARGV[1]
    @translator = Dictionary.new(true)
    @input_file = read.chomp
    @output_file = write
    puts confirmation_message
  end

  def confirmation_message
    "Created '#{@output_filename}' containing #{output_file.length} characters"
  end

  def translate
    braille_rows = @input_file.split("\n")
    translation = ""
    while !braille_rows.empty?
      translation += translate_line(braille_rows.slice!(0, 3)).join
    end
    translation
  end

  def translate_line(braille_line)
    braille_nums = braille_line_to_braille_nums(braille_line)
    braille_nums_by_character_sorted = sort(group_by_character(braille_nums))
    braille_nums_by_character_sorted.map { |nums| @translator.get(nums)}
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

  def group_by_character(braille_nums)
    braille_nums[0].zip(braille_nums[1], braille_nums[2])
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

  def sort(braille_nums_by_character)
    braille_nums_by_character.map do |nums|
      if nums.join == ""
        "0"
      else
        nums.join.split(//).sort.join
      end
    end
  end
end
