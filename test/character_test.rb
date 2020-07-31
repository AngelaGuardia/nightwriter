require './test/test_helper'
require './lib/character'

class CharacterTest < Minitest::Test
  def setup
    @character = Character.new("b", "12")
  end

  def test_it_exists
    assert_instance_of Character, @character
  end

  def test_it_has_readable_attributes
    assert_equal "b", @character.symbol
    assert_equal ["1", "2"], @character.dot_nums
  end

  def test_it_can_create_and_read_dots
    assert_equal true, @character.dots.all? { |num, dot| dot.class == Dot }
    assert_equal 6, @character.dots.length
  end

  def test_it_can_turn_on_dots
    assert_equal true, @character.dots["1"].on?
    assert_equal true, @character.dots["2"].on?
    assert_equal false, @character.dots["3"].on?
    assert_equal false, @character.dots["4"].on?
    assert_equal false, @character.dots["5"].on?
    assert_equal false, @character.dots["6"].on?
  end

  def test_it_can_render_by_row
    assert_equal "0.", @character.render_row1
    assert_equal "0.", @character.render_row2
    assert_equal "..", @character.render_row3
  end
end
