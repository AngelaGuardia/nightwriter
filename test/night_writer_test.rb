require './test/test_helper'
require './lib/night_writer'
require 'minitest/stub_const'
require 'mocha/minitest'

class NightWriterTest < Minitest::Test
  def setup
    NightWriter.any_instance.stubs(:print_output)
    @writer = NightWriter.new
  end

  def test_it_exists
    assert_instance_of NightWriter, @writer
  end

  def test_it_takes_in_command_line_arguments
    assert_equal 2, ARGV.length
  end

  def test_it_has_readable_attributes
    # Object.stub_const(:ARGV, ["plain_file", "braille_file"]) do
      assert_equal "message.txt", @writer.plain_filename
      assert_equal "braille.txt", @writer.braille_filename
    # end
  end

  def test_assert_it_can_read_a_file_and_has_readable_attr
    assert_instance_of String, @writer.plain_text
  end

  def test_it_can_write_a_file

  end
end
