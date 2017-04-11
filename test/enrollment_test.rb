gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'enrollment'
require 'pry'

class EnrollmentTest < Minitest::Test

  def test_init
    en = Enrollment.new
    assert_instance_of Enrollment, en
  end

  def test_if_it_has_name
    en = Enrollment.new(@name = "ACADEMY 20")
    assert_equal "ACADEMY 20", en.name
  end

end
