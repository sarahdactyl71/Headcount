gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test

  attr_reader :er

  def setup
    @er = EnrollmentRepository.new
    er.load_data({
        :enrollment => {
          :kindergarten => "./data/Kindergartners in full-day program.csv",
          :high_school_graduation => "./data/High school graduation rates.csv"
        }
      })
  end

  def test_init
    assert_instance_of EnrollmentRepository, er
  end

  def test_load_data
    enrollment = er.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20", enrollment.name
    assert_equal 0.436, enrollment.kindergarten_participation_in_year(2010)
    assert_equal 0.353, enrollment.kindergarten_participation_in_year(2006)
  end

  def test_load_grads
    enrollment = er.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20", enrollment.name
    info = {2010=>0.895, 2011=>0.895, 2012=>0.889, 2013=>0.913, 2014=>0.898}
    assert_equal info, enrollment.graduation_rate_by_year
    assert_equal 0.895, enrollment.graduation_rate_in_year(2010)
  end

  def test_load_data_two
    enrollment = er.find_by_name("JOHNSTOWN-MILLIKEN RE-5J")
    enrollment2 = er.find_by_name("ACADEMY 20")
    assert_equal "JOHNSTOWN-MILLIKEN RE-5J", enrollment.name
    assert_equal "ACADEMY 20", enrollment2.name
  end

  # def test_what_are_the_kindergarten_years
  #   skip
  #   er = EnrollmentRepository.new
  #   er.load_data({
  #       :enrollment => {
  #         :kindergarten => "./data/Kindergartners in full-day program.csv"
  #       }
  #     })
  #   enrollment = er.add_kindergarten_participation_data(dates)
  #   assert_equal { 2010 => 0.391,
  #                  2011 => 0.353,
  #                  2012 => 0.267}, enrollment.dates
  # end
end
