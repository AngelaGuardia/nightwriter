require './test/test_helper'
require 'mocha/minitest'
require './lib/dictionary'

class DictionaryTest < Minitest::Test
  def setup
    @dictionary = Dictionary.new
  end

  def test_it_exists
    assert_instance_of Dictionary, @dictionary
  end

  def test_it_has_readable_attributes
    assert_instance_of Hash, @dictionary.dictionary
  end

  def test_it_generates_dictionary_from_file
    assert_equal 27, @dictionary.dictionary.length
  end

  def test_it_can_get_a_value
    assert_equal "12", @dictionary.get("b")
  end
end
