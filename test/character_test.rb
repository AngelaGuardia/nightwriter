require './test/test_helper'
require './lib/character'

class CharacterTest < Minitest::Test
  def setup
    @character = Character.new
  end

  def test_it_exists
    assert_instance_of Character, @character
  end
end
