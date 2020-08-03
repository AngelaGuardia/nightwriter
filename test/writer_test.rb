require './test/test_helper'
require './lib/writer'
require 'minitest/stub_const'
require 'mocha/minitest'

class WriterTest < Minitest::Test
  def setup
    Writer.any_instance.stubs(:puts)
  end

  def test_it_exists
    writer = Writer.new

    assert_instance_of Writer, writer
  end

  def test_it_takes_in_command_line_arguments
    assert_equal true, ARGV.length > 0
  end

  def test_it_can_read_filename_attributes
    File.stubs(:read).returns("test string")
    Object.stub_const(:ARGV, ["plain", "braille"]) do
      Writer.any_instance.stubs(:write)
      writer2 = Writer.new

      assert_equal "plain", writer2.input_filename
      assert_equal "braille", writer2.output_filename
    end
  end

  def test_it_can_read_other_attributes
    File.stubs(:read).returns("stubbed")
    writer = Writer.new

    assert_equal "stubbed", writer.input_file
  end

  def test_assert_it_can_read_a_file
    Object.stub_const(:ARGV, ["data/message_fixture.txt", "braille.txt"]) do
      Writer.any_instance.stubs(:write)
      writer = Writer.new

      assert_equal "hello world", writer.input_file
    end
  end

  def test_it_can_write_a_file
    Object.stub_const(:ARGV, ["data/message_fixture.txt", "braille.txt"]) do
      Writer.any_instance.stubs(:translate).returns("I can write")
      writer = Writer.new

      expected =  "I can write"

      assert_equal expected, writer.output_file
    end
  end

  def test_it_can_write_braille
    Object.stub_const(:ARGV, ["data/message_fixture.txt", "braille.txt"]) do
      writer = Writer.new

      expected =  "0.0.0.0.0....00.0.0.00\n" +
                  "00.00.0..0..00.0000..0\n" +
                  "....0.0.0....00.0.0..."

      assert_equal expected, writer.output_file
    end
  end

  def test_it_can_print_confirmation_message
    Object.stub_const(:ARGV, ["data/message_fixture.txt", "braille.txt"]) do
      writer = Writer.new
      expected = "Created 'braille.txt' containing 11 characters"
      assert_equal expected, writer.confirmation_message
    end
  end

  def test_it_can_split_strings
    str = "01234567890123456789012345678901234567890123456789"
    Writer.any_instance.stubs(:input_file).returns(str)
    Writer.any_instance.stubs(:read).returns(str)
    Writer.any_instance.stubs(:write)
    Writer.any_instance.stubs(:confirmation_message)
    writer = Writer.new

    expected = ["0123456789012345678901234567890123456789", "0123456789"]

    assert_equal expected, writer.split_strings
  end
end
