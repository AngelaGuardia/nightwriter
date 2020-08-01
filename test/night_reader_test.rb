require './test/test_helper'
require './lib/night_reader'
require 'minitest/stub_const'
require 'mocha/minitest'

class NightReaderTest < Minitest::Test
  def test_it_exists
    reader = NightReader.new

    assert_instance_of NightReader, reader
  end

  def test_it_takes_in_command_line_arguments
    assert_equal true, ARGV.length > 0
  end

  def test_it_can_read_filename_attributes
    reader = NightReader.new

    assert_equal "braille.txt", reader.braille_filename
    assert_equal "original_message.txt", reader.translated_filename
  end
end
