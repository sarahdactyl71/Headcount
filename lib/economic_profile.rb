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
  end

  def median_household_income_average
    compiler = compile_everything(@median_household_income)
    average(compiler)
  end

  def children_in_poverty_in_year(year)
    output = selector(@children_in_poverty, year)
    output.to_f
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    output = lunch_selector(@free_or_reduced_price_lunch, year)
    truncate(output)
  end

  def lunch_selector(data, year)
    data.select do |row|
      if row[:timeframe].to_i == year && row[:location] == name.upcase && row[:dataformat] == "Percent" && row[:poverty_level] == "Eligible for Free or Reduced Lunch"
        return row[:data].to_f
      else
        next
      end
    end
  end

  def selector(data, year)
    data.select do |row|
      if row[:timeframe].to_i == year && row[:location] == name.upcase && row[:dataformat] == "Percent"
        return row[:data]
      else
        next
      end
    end
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

  def compile_everything(data)
    compiler = []
      data.select do |row|
        if row[:location] == name
            compiler << row
        end
      end
    return compiler
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

end
