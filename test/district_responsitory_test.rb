gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class DistrictReponsitoryTest < Minitest::Test
  def test_init
    dr = DistrictRepository.new
    assert_instance_of DistrictRepository, dr
  end

  def test_load_data
    dr = DistrictRepository.new
    dr.load_data({
        :enrollment => {
          :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    district = dr.find_by_name("academy 20")
    assert_equal "ACADEMY 20" , district
  end

  def test_load_data_two
    skip
    dr = DistrictRepository.new
    dr.load_data({
        :enrollment => {
          :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    district = dr.find_by_name("JOHNSTOWN-MILLIKEN RE-5J")
    assert_equal 11, district.count
  end

end
