gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'
require 'pry'

class EnrollmentTest < Minitest::Test

  attr_reader :en

  def setup
    @en = Enrollment.new(:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677})
  end

  def test_init
    assert_instance_of Enrollment, en
  end

  def test_if_it_has_name
    assert_equal "ACADEMY 20", en.name
  end

  def test_what_percentage_to_a_year
    assert_equal 0.391, en.kindergarten_participation_in_year(2010)
  end

  def test_does_it_pull_in_graduation_rate
  end
  
end
