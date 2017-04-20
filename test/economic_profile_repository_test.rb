gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/economic_profile_repository'


class EconomicProfileRepositoryTest < Minitest::Test

  attr_reader :epr,
              :data

  def setup
    @epr = EconomicProfileRepository.new
    @data = {
    :economic_profile => {
    :median_household_income => "./data/Median household income.csv",
    :children_in_poverty => "./data/School-aged children in poverty.csv",
    :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
    :title_i => "./data/Title I students.csv"
  }
}
  end

  def test_init
    assert_instance_of EconomicProfileRepository, epr
  end

  def test_does_it_know_it_is_an_economic_profile_repo
  	assert_equal EconomicProfileRepository, epr.class
  end


end
