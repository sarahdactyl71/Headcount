gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'
require './lib/district_repository'

class DistrictTest < Minitest::Test

    attr_reader :dr

    def setup
      @dr = DistrictRepository.new
          dr.load_data({:enrollment => {:kindergarten => "./data/Kindergartners in full-day program.csv"}})
    end

    def test_district_basics
      district = District.new({:name => "ACADEMY 20"})
      assert_equal "ACADEMY 20", district.name
    end

    def test_does_it_call_enrollment
      district = dr.find_by_name("ACADEMY 20")
      assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
    end

end
