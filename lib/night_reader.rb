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
end
