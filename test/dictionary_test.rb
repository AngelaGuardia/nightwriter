require './test/test_helper'
require './lib/dictionary'

class DictionaryTest < Minitest::Test
  def setup
    @dictionary = Dictionary.new
  end

  def test_it_exists
    assert_instance_of Dictionary, @dictionary
  end
end
