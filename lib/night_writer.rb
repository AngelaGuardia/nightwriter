class NightWriter
  attr_reader :plain_filename,
              :braille_filename,
              :plain_text

  def initialize
    @plain_filename = ARGV[0]
    @braille_filename = ARGV[1]
    read
  end

  def read
    @plain_text = File.read(@plain_filename).delete("\n")
    print_output(@braille_filename, plain_text)
  end

  def print_output(braille_filename, plain_text)
    puts "Created '#{braille_filename}' containing #{plain_text.length} characters"
  end

  def write

  end
end
