gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'
require './lib/district_repository'

class DistrictTest < Minitest::Test
    def test_district_basics
      district = District.new({:name => "ACADEMY 20"})
      assert_equal "ACADEMY 20", district.name
    end
end
