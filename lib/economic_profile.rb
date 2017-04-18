require_relative "economic_profile_repository"
require_relative "helper_module"
require 'pry'

class EconomicProfile

  include Helper
  attr_reader :median_household_income,
              :children_in_poverty,
              :free_or_reduced_price_lunch,
              :title_i,
              :name

  def initialize(args)
    @median_household_income = args[:median_household_income]
    @children_in_poverty = args[:children_in_poverty]
    @free_or_reduced_price_lunch = args[:free_or_reduced_price_lunch]
    @title_i = args[:title_i]
    @name = args[:name]
  end

  def median_household_income_in_year(year)
    compiler = compiler(@median_household_income, year)
    average(compiler)
    binding.pry
  end

  def average(data)
    numbers = []
    data.map do |row|
      numbers << row[:data].to_i
    end
    sum = numbers.reduce(0) { |a, sum| a + sum }
    average = (sum/(numbers.count))
    average
  end

  def compiler(key, year)
  compiler = []
    key.select do |row|
      if date_range(row[:timeframe]).include?(year) && row[:location] == name
        compiler << row
      end
    end
  return compiler
  end

  def date_range(range)
    first = range[0..3].to_i
    last = range[5..8].to_i
    output = (first..last).to_a
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
