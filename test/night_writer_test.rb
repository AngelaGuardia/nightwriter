require './test/test_helper'
require './lib/night_writer'
require 'minitest/stub_const'
require 'mocha/minitest'

class NightWriterTest < Minitest::Test
  def setup
    NightWriter.any_instance.stubs(:print_output)
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
      writer2 = NightWriter.new
      assert_equal "plain", writer2.plain_filename
      assert_equal "braille", writer2.braille_filename
    end
  end

  def test_it_can_read_other_attributes
    File.stubs(:read).returns("test string")
    writer = NightWriter.new

    assert_equal "test string", writer.plain_file
  end

  def test_assert_it_can_read_a_file_and_has_readable_attr
    assert_instance_of String, @writer.plain_file
  end

  def test_it_can_write_a_file
    skip
    assert_instance_of String, @writer.braille_file
  end

  def test_it_can_write_braille

  end
end
