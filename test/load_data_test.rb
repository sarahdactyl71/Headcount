gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/load_data'

class LoadDataTest < Minitest::Test

  include LoadData

  def test_what_does_it_say
    assert_equal "Hello", says_hi
  end
  
end
