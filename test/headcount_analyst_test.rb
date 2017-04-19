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
    variation = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 }
    assert_equal variation, ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end

  def test_highschool_kindergarten_rates
    assert_equal 0.548, ha.kindergarten_participation_against_high_school_graduation('MONTROSE COUNTY RE-1J')
  end

  def test_if_kg_corrletates_wiht_hs_grad
    assert ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
  end

  def test_if_statewide_kg_participation_correlates_with_state
    skip
    refute ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'STATEWIDE')
  end

  def test_if_we_can_have_more_than_one_district
    assert ha.kindergarten_participation_correlates_with_high_school_graduation(
    :across => ['ACADEMY 20', 'ADAMS COUNTY 14', 'BRIGHTON 27J', 'CHERRY CREEK 5'])
  end

  def test_new_loading
    largest = ["FRENCHMAN RE-3", 0.313]
    assert_equal largest, ha.top_statewide_test_year_over_year_growth(grade: 3, subject: :math)
    top_three = [["FRENCHMAN RE-3", 0.313], ["WILEY RE-13 JT", 0.3], ["LA VETA RE-2", 0.162]]
    assert_equal top_three, ha.top_statewide_test_year_over_year_growth(grade: 3, top: 3, subject: :math)
    top_four = [["FRENCHMAN RE-3", 0.313], ["WILEY RE-13 JT", 0.3], ["LA VETA RE-2", 0.162], ["WELDON VALLEY RE-20(J)", 0.135]]
    assert_equal top_four, ha.top_statewide_test_year_over_year_growth(grade: 3, top: 4, subject: :math)
    assert_equal "SANGRE DE CRISTO RE-22J", ha.top_statewide_test_year_over_year_growth(grade: 3)
  end


end
