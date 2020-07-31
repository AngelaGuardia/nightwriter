class NightWriter
  attr_reader :plain_text

  def initialize
    read
  end

  def read
    plain_filename = ARGV[0]
    @plain_text = File.read(plain_filename).delete("\n")
    braille_filename = ARGV[1]
    print_output(braille_filename, plain_text)
  end

  def print_output(braille_filename, plain_text)
    puts "Created '#{braille_filename}' containing #{plain_text.length} characters"
  end
end
