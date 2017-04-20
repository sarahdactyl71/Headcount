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

  def test_it_has_a_class
    assert_equal EconomicProfile, ep.class
  end

  def test_can_it_pull_in_a_median_income
    assert_equal 85060, ep.median_household_income_in_year(2005)
    assert_equal 87635, ep.median_household_income_in_year(2009)
    assert_equal 89222, ep.median_household_income_in_year(2011)
  end


  def test_median_household_income
    income = ep.median_household_income_average
    assert_equal 87635, income
    assert_equal Fixnum, income.class
  end

  def test_percentage_of_students_in_title_i_in_year
    assert_equal 0.027, ep.title_i_in_year(2014)
    assert_equal 0.011, ep.title_i_in_year(2011)
    assert_equal 0.012, ep.title_i_in_year(2013)
    assert_equal 0.014, ep.title_i_in_year(2009)
  end

  def test_children_in_poverty_over_years
    assert_equal 0.064, ep.children_in_poverty_in_year(2012)
    assert_equal 0.04404, ep.children_in_poverty_in_year(2008)
    assert_equal 0.042, ep.children_in_poverty_in_year(2005)
    assert_equal 0.05754, ep.children_in_poverty_in_year(2010)
  end

  def test_percentage_of_free_or_reduced_lunch
    assert_equal 0.127, ep.free_or_reduced_price_lunch_percentage_in_year(2014)
    assert_equal 0.119, ep.free_or_reduced_price_lunch_percentage_in_year(2011)
    assert_equal 0.08, ep.free_or_reduced_price_lunch_percentage_in_year(2007)
    assert_equal 0.103, ep.free_or_reduced_price_lunch_percentage_in_year(2009)
  end

  def test_number_of_students_with_free_or_reduced_lunches
    assert_equal 3132, ep.free_or_reduced_price_lunch_number_in_year(2014)
    assert_equal 2834, ep.free_or_reduced_price_lunch_number_in_year(2011)
    assert_equal 1630, ep.free_or_reduced_price_lunch_number_in_year(2007)
    assert_equal 2338, ep.free_or_reduced_price_lunch_number_in_year(2009)
  end

  def test_relationship
    assert epr.find_by_name('ACADEMY 20').is_a?(EconomicProfile)
  end

  def test_edge_cases
    assert_raises(UnknownDataError) do
      ep.children_in_poverty_in_year(3000)
    end
    assert_raises(UnknownDataError) do
      ep.free_or_reduced_price_lunch_percentage_in_year("pizza")
    end
    assert_raises(UnknownDataError) do
      ep.free_or_reduced_price_lunch_number_in_year(1890)
    end
  end

end
