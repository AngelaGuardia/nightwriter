require './lib/line'
require './lib/file_io'

class Writer
  include FileIO

  attr_reader :input_filename,
              :output_filename,
              :input_file,
              :output_file

  def initialize
    @input_filename = ARGV[0]
    @output_filename = ARGV[1]
    @input_file = read.delete("\n")
    @output_file = write
    puts confirmation_message
  end

  def translate
    split_strings.reduce("") do |text, string|
      line = Line.new(string)
      text += line.render
      text += "\n" unless string == split_strings.last
      text
    end
  end

  def split_strings
    input_file.downcase.scan(/.{1,40}/)
  end

  def confirmation_message
    "Created '#{@output_filename}' containing #{@input_file.length} characters"
  end
end
