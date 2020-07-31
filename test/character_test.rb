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
    assert_equal ["1", "2"], @character.dots
  end
end
