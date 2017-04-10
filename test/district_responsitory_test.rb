gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class DistrictReponsitoryTest < Minitest::Test
  def test_init
    dr = DistrictRepository.new
    assert_instance_of DistrictRepository, dr
  end

  
end
