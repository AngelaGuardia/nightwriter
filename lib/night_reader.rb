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
    @translated_text = translate_braille
    File.open(@translated_filename, "w") { |f| f.write(@translated_text) }
    @translated_file = File.read(@translated_filename)
  end
end
