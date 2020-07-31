require './test/test_helper'
require './lib/dot'

class DotTest < Minitest::Test
  def setup
    @dot = Dot.new
  end

  def test_it_exists
    assert_instance_of Dot, @dot
  end
end
