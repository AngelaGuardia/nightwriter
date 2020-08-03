require './test/test_helper'
require './lib/night_reader'
require 'minitest/stub_const'
require 'mocha/minitest'

class NightReaderTest < Minitest::Test
  def setup
    NightReader.any_instance.stubs(:puts)
  end

  def test_it_exists
    NightReader.any_instance.stubs(:read)
    NightReader.any_instance.stubs(:write)
    NightReader.any_instance.stubs(:confirmation_message)

    reader = NightReader.new

    assert_instance_of NightReader, reader
  end

  def test_it_can_read_filename_attributes
    NightReader.any_instance.stubs(:read)
    NightReader.any_instance.stubs(:write)
    NightReader.any_instance.stubs(:confirmation_message)
    Object.stub_const(:ARGV, ["braille", "translated"]) do
      reader = NightReader.new

      assert_equal "braille", reader.input_filename
      assert_equal "translated", reader.output_filename
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
      NightReader.any_instance.stubs(:translate).returns("I can translate")
      reader = NightReader.new
      reader.write

      assert_equal "I can translate", reader.output_file
    end
  end

  def test_it_can_print_confirmation_message
    Object.stub_const(:ARGV, ["data/braille_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new
      reader.stubs(:output_file).returns("hello world")
      expected = "Created 'original_message.txt' containing 11 characters"

      assert_equal expected, reader.confirmation_message
    end
  end

  def test_it_can_translate_braille
    Object.stub_const(:ARGV, ["data/braille_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new
      reader.read
      expected = "hello world"

      assert_equal expected, reader.translate
    end
  end

  def test_it_can_translate_multiple_lines
    Object.stub_const(:ARGV, ["data/braille_long_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new
      reader.read
      expected = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

      assert_equal expected, reader.translate
    end
  end

  def test_it_can_translate_braille_row_to_braille_nums
    NightReader.any_instance.stubs(:read)
    NightReader.any_instance.stubs(:write)
    NightReader.any_instance.stubs(:confirmation_message)
    reader = NightReader.new
    row = ["0.", ".0", "00", ".."]

    assert_equal ["1", "4", "14", ""], reader.braille_nums_row1(row)
    assert_equal ["2", "5", "25", ""], reader.braille_nums_row2(row)
    assert_equal ["3", "6", "36", ""], reader.braille_nums_row3(row)
  end

  def test_it_can_sort_braille_nums_by_character
    Object.stub_const(:ARGV, ["data/braille_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new
      braille_nums_by_character = [["1", "25", ""],
                                   ["1", "5", ""],
                                   ["1", "2", "3"],
                                   ["1", "2", "3"],
                                   ["1", "5", "3"],
                                   ["", "", ""],
                                   ["4", "25", "6"],
                                   ["1", "5", "3"],
                                   ["1", "25", "3"],
                                   ["1", "2", "3"],
                                   ["14", "5", ""]]

      expected = ["125", "15", "123", "123", "135", "0", "2456", "135", "1235", "123", "145"]

      assert_equal expected, reader.join_and_sort_braille_nums_by_character(braille_nums_by_character)
    end
  end

  def test_it_can_translate_braille_line_to_braille_nums
    Object.stub_const(:ARGV, ["data/braille_fixture.txt", "original_message.txt"]) do
      reader = NightReader.new
      braille_line = ["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."]

      expected = [["1", "1", "1", "1", "1", "", "4", "1", "1", "1", "14"], ["25", "5", "2", "2", "5", "", "25", "5", "25", "2", "5"], ["", "", "3", "3", "3", "", "6", "3", "3", "3", ""]]

      assert_equal expected, reader.braille_line_to_braille_nums(braille_line)
    end
  end
end
