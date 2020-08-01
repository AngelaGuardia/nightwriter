class NightReader
  attr_reader :braille_filename,
              :translated_filename
              
  def initialize
    @braille_filename = ARGV[0]
    @translated_filename = ARGV[1]
  end
end
