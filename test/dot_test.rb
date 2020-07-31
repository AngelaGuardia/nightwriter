require './test/test_helper'
require './lib/dot'

class DotTest < Minitest::Test
  def setup
    @dot = Dot.new(1)
  end

  def test_it_exists
    assert_instance_of Dot, @dot
  end

  def test_it_has_readable_attributes
    assert_equal 1, @dot.number
    assert_equal false, @dot.is_on
  end

  def test_it_can_turn_on
    @dot.turn_on
    assert_equal true, @dot.is_on
  end
end
