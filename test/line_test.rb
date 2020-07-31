require './test/test_helper'
require './lib/character'
require './lib/line'

class LineTest < Minitest::Test
  def setup
    @line = Line.new
  end

  def test_it_exists
    assert_instance_of Line, @line
  end

  def test_it_has_readable_attributes
    assert_equal [], @line.characters
  end

  def test_it_can_add_characters
    chr1 = Character.new("b", "12")
    @line.add_character(chr1)
    assert_equal [chr1], @line.characters
  end

end
