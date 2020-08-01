require './test/test_helper'
require './lib/night_reader'
require 'minitest/stub_const'
require 'mocha/minitest'

class NightReaderTest < Minitest::Test
  def test_it_exists
    reader = NightReader.new

    assert_instance_of NightReader, reader
  end

  def test_it_can_read_filename_attributes
    Object.stub_const(:ARGV, ["braille", "translated"]) do
      reader = NightReader.new

      assert_equal "braille", reader.braille_filename
      assert_equal "translated", reader.translated_filename
    end
  end

  def test_it_can_read_a_file
    Object.stub_const(:ARGV, ["data/braille_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new

      expected =  "0.0.0.0.0....00.0.0.00\n" +
                  "00.00.0..0..00.0000..0\n" +
                  "....0.0.0....00.0.0..."

      assert_equal expected, reader.read
    end
  end
end
