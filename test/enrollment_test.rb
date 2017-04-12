gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'
require 'pry'

class EnrollmentTest < Minitest::Test

  def test_init
    en = Enrollment.new(:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677})
    assert_instance_of Enrollment, en
  end

  def test_if_it_has_name
    en = Enrollment.new(:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677})
    assert_equal "ACADEMY 20", en.name
  end

  def test_what_percentage_to_a_year
    en = Enrollment.new(:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677})
    assert_equal 0.3915, en.kindergarten_participation_in_year(2010)
  end

end
