gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'load_data'

class LoadDataTest < Minitest::Test

  include LoadData

  attr_reader :data

  def setup
    @data = {:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}}
  end

  def test_does_it_load
    assert load_data(data)
  end

  def test_what_does_it_say
    assert_equal "Hello", says_hi
  end

end
