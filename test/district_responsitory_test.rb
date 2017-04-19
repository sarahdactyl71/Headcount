gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class DistrictReponsitoryTest < Minitest::Test

  attr_reader :dr

  def setup
    @dr = DistrictRepository.new
    dr.load_data({
        :enrollment => {
          :kindergarten => "./data/Kindergartners in full-day program.csv"
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


end
