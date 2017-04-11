gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'
require './lib/district_repository'

class DistrictTest < Minitest::Test
  def test_init
  dr = DistrictRepository.new
  dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
  district = dr.find_by_name("academy 20")
  assert_instance_of District, district
  end

end
