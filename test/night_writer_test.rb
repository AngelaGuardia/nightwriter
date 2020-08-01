require './test/test_helper'
require './lib/night_writer'
require 'minitest/stub_const'
require 'mocha/minitest'

class NightWriterTest < Minitest::Test
  def setup
    NightWriter.any_instance.stubs(:puts)
  end

  def test_it_exists
    writer = NightWriter.new

    assert_instance_of NightWriter, writer
  end

  def test_it_takes_in_command_line_arguments
    assert_equal true, ARGV.length > 0
  end

  def test_it_can_read_filename_attributes
    File.stubs(:read).returns("test string")
    Object.stub_const(:ARGV, ["plain", "braille"]) do
      NightWriter.any_instance.stubs(:write)
      writer2 = NightWriter.new

      assert_equal "plain", writer2.plain_filename
      assert_equal "braille", writer2.braille_filename
    end
  end

  def test_it_can_read_other_attributes
    File.stubs(:read).returns("stubbed")
    writer = NightWriter.new

    assert_equal "stubbed", writer.plain_file
  end

  def test_assert_it_can_read_a_file
    Object.stub_const(:ARGV, ["data/message_fixture.txt", "braille.txt"]) do
      NightWriter.any_instance.stubs(:write)
      writer = NightWriter.new

      assert_equal "hello world", writer.plain_file
    end
  end

  def test_it_can_write_a_file
    Object.stub_const(:ARGV, ["data/message_fixture.txt", "braille.txt"]) do
      NightWriter.any_instance.stubs(:write_braille).returns("I can write")
      writer = NightWriter.new

      expected =  "I can write"

      assert_equal expected, writer.braille_file
    end
  end

  def test_it_can_write_braille
    Object.stub_const(:ARGV, ["data/message_fixture.txt", "braille.txt"]) do
      writer = NightWriter.new

      expected =  "0.0.0.0.0....00.0.0.00\n" +
                  "00.00.0..0..00.0000..0\n" +
                  "....0.0.0....00.0.0..."

      assert_equal expected, writer.braille_file
    end
  end

  def test_it_can_print_confirmation_message
    Object.stub_const(:ARGV, ["data/message_fixture.txt", "braille.txt"]) do
      writer = NightWriter.new
      expected = "Created 'braille.txt' containing 11 characters"
      assert_equal expected, writer.confirmation_message
    end
  end

  def test_it_can_split_strings
    str = "01234567890123456789012345678901234567890123456789"
    NightWriter.any_instance.stubs(:plain_file).returns(str)
    NightWriter.any_instance.stubs(:read)
    NightWriter.any_instance.stubs(:write)
    writer = NightWriter.new

    expected = ["0123456789012345678901234567890123456789", "0123456789"]

    assert_equal expected, writer.split_strings
  end
end
