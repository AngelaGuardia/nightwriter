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

  def test_it_can_write_a_file
    Object.stub_const(:ARGV, ["data/braille_fixture.txt", "original_message.txt"]) do
      NightReader.any_instance.stubs(:translate_braille).returns("I can translate")
      reader = NightReader.new
      reader.write

      assert_equal "I can translate", reader.translated_file
    end
  end

  def test_it_can_print_confirmation_message
    Object.stub_const(:ARGV, ["data/braille_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new
      reader.stubs(:translated_file).returns("hello world")
      expected = "Created 'original_message.txt' containing 11 characters"

      assert_equal expected, reader.confirmation_message
    end
  end

  def test_it_can_translate_braille
    Object.stub_const(:ARGV, ["data/braille_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new
      reader.read
      expected = "hello world"

      assert_equal expected, reader.translate_braille
    end
  end

  def test_it_can_translate_multiple_lines
    Object.stub_const(:ARGV, ["data/braille_long_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new
      reader.read
      expected = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

      assert_equal expected, reader.translate_braille
    end
  end
end
