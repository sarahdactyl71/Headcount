gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class DistrictReponsitoryTest < Minitest::Test

  attr_reader :dr

  def setup
    @dr = DistrictRepository.new
    dr.load_data({:enrollment => {
                    :kindergarten => "./data/Kindergartners in full-day program.csv",
                    :high_school_graduation => "./data/High school graduation rates.csv",
                   },
                   :statewide_testing => {
                     :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                     :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                     :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                   }
                 })
  end

  def test_init
    assert_instance_of DistrictRepository, dr
  end

  def test_load_data_if_case_insensitive
    district = dr.find_by_name("academy 20")
    assert_equal "ACADEMY 20", district.name
    assert_equal District, district.class
  end

  def test_load_data_if_upcase
    district = dr.find_by_name("JOHNSTOWN-MILLIKEN RE-5J")
    assert_equal "JOHNSTOWN-MILLIKEN RE-5J", district.name
    assert_equal District, district.class
  end

  def test_empty_districts_by_default
    assert dr.districts
    assert_equal Array, dr.districts.class
    assert dr.districts.empty?
  end

  def test_if_district_exists
    district = dr.find_by_name("LAND OF OOO")
    assert_nil district
  end

  def test_makes_statewide_repo_when_loading_its_own_data
    district = dr.find_by_name('ACADEMY 20')
    statewide_test = dr.statewide_test.find_by_name('ACADEMY 20')
    assert_equal 'ACADEMY 20', statewide_test.name
    assert_equal StatewideTest, statewide_test.class
  end

  def test_makes_economic_repo_when_loading
    district = dr.find_by_name('ACADEMY 20')
    ep = dr.economic_repository.find_by_name('ACADEMY 20')
    assert_equal 'ACADEMY 20', ep.name
    assert_equal EconomicProfile, ep.class
  end

  def test_makes_enrollment_repo_when_loading
    district = dr.find_by_name('ACADEMY 20')
    en = dr.enrollment_repository.find_by_name('ACADEMY 20')
    assert_equal 'ACADEMY 20', en.name
    assert_equal Enrollment, en.class
  end


end
