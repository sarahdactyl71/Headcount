gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/economic_profile'


class EconomicProfileTest < Minitest::Test

  attr_reader :epr,
              :ep
  def setup
    @epr = EconomicProfileRepository.new
    epr.load_data({
    :economic_profile => {
    :median_household_income => "./data/Median household income.csv",
    :children_in_poverty => "./data/School-aged children in poverty.csv",
    :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
    :title_i => "./data/Title I students.csv"
    }
    })
    @ep = epr.find_by_name("ACADEMY 20")
  end

  def test_can_it_pull_in_a_median_income
    assert_equal 85060, ep.median_household_income_in_year(2005)
    assert_equal 87635, ep.median_household_income_in_year(2009)
  end

  def test_median_everything
    assert_equal 87635, ep.median_household_income_average
    assert_equal 0.064, ep.children_in_poverty_in_year(2012)
    assert_equal 0.127, ep.free_or_reduced_price_lunch_percentage_in_year(2014)
    assert_equal 3132, ep.free_or_reduced_price_lunch_number_in_year(2014)
    assert_equal 0.027, ep.title_i_in_year(2014)
  end

  def test_relationship
    assert epr.find_by_name('ACADEMY 20').is_a?(EconomicProfile)
  end

end
