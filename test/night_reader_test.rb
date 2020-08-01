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


end
