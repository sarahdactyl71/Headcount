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

  def test_load_data
    district = dr.find_by_name("academy 20")
    assert_equal "ACADEMY 20", district.name
    #assert_equal true, district.enrollment_repository.kindergarten_participation_in_year(2010)
    end

  def test_load_data_two
    district = dr.find_by_name("JOHNSTOWN-MILLIKEN RE-5J")
    assert_equal "JOHNSTOWN-MILLIKEN RE-5J", district.name
    end

end
