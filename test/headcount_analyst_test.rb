gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/headcount_analyst'
require './lib/district_repository'

class HeadcountAnalystTest < Minitest::Test

  attr_reader :dr,
              :ha

  def setup
    @dr = DistrictRepository.new
    dr.load_data({
        :enrollment => {
          :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    district = dr.find_by_name("JOHNSTOWN-MILLIKEN RE-5J")
    @ha = HeadcountAnalyst.new(dr)
  end

  def test_it_is_a_headcount_analyst
    assert ha
    assert_equal HeadcountAnalyst, ha.class
  end


  def test_it_has_district_repository_by_defaul
    assert_equal DistrictRepository, ha.district_repository.class
  end

  def test_district_participation_rate_varies_with_state
    assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

  def test_how_do_district_participation_compare
    assert_equal 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
  end

  def test_how_do_district_participation_compare_with_state_by_year
    assert_equal {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 } , ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO') 
  end

end
