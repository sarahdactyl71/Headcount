require_relative "economic_profile_repository"
require_relative "helper_module"
require 'pry'

class EconomicProfile

  include Helper

  def initialize(args)
    @median_household_income = args[:median_household_income]
    @children_in_poverty = args[:children_in_poverty]
    @free_or_reduced_price_lunch = args[:free_or_reduced_price_lunch]
    @title_i = args[:title_i]
    @name = args[:name]
  end

  def median_household_income_in_year(year)
  end

  # def is_it_valid?(input)
  #   valid_entry = [:asian, :black, :pacific_islander, :hispanic,
  #                 :native_american, :two_or_more, :white, :math,
  #                 :reading, :writing, 3, 8]
  #    if valid_entry.include?(input) == false
  #      raise UnknownDataError
  #    else
  #      input
  #    end
  # end
end
