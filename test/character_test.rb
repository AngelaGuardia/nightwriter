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
    assert_equal true, @character.dots.all? { |dot| dot.class == Dot }
    assert_equal 6, @character.dots.length
  end
end
