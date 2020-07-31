require './test/test_helper'
require './lib/night_writer'
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

  def test_assert_it_can_read_a_file_and_has_readable_attr
    assert_instance_of String, @writer.plain_text
  end

  def test_it_can_write_a_file

  end
end
