require './test/test_helper'
require './lib/character'
require './lib/line'

class LineTest < Minitest::Test
  def setup
    string = "hello"
    @line = Line.new(string)
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

  def test_it_knows_its_length
    chr1 = Character.new("b", "12")
    chr2 = Character.new("a", "1")

    assert_equal 0, @line.length

    @line.add_character(chr1)
    assert_equal 1, @line.length

    @line.add_character(chr2)
    assert_equal 2, @line.length
  end

  def test_it_can_generate_characters
    @line.generate_characters

    assert_equal 5, @line.length
    assert_equal true, @line.characters.all? { |char| char.class == Character }
    assert_equal "h", @line.characters[0].symbol
  end

  def test_it_can_render_itself
    @line.generate_characters

    expected =  "0.0.0.0.0.\n" +
                "00.00.0..0\n" +
                "....0.0.0."

    assert_equal expected, @line.render
  end
end
