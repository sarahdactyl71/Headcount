require_relative "economic_profile_repository"
require_relative "helper_module"
require_relative "error"
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
    if @median_household_income.class == Hash
      find_median(year)
    else
      compiler = compiler(@median_household_income, year)
      is_output_valid?(average(compiler))
    end
  end

  def median_household_income_average
    compiler = compile_everything(@median_household_income)
    average = average(compiler)
    is_output_valid?(average)
  end

  def children_in_poverty_in_year(year)
    output = selector(@children_in_poverty, year)
    output = output.to_f
    is_output_valid?(output)
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    output = lunch_selector(@free_or_reduced_price_lunch, year)
    is_output_valid?((truncate(output)))
  end

  def free_or_reduced_price_lunch_number_in_year(year)
    output = lunch_number_selector(@free_or_reduced_price_lunch, year)
    is_output_valid?((truncate(output)))
  end

  def title_i_in_year(year)
    output = selector(@title_i, year)
    is_output_valid?((truncate(output)))
  end

  def find_median(year)
    @median_household_income.each do |key, value|
      if key.include?(year)
        return @median_household_income[key]
        end
    end
  end

  def lunch_selector(data, year)
    output = data.select do |row|
      if row[:timeframe].to_i == year && row[:location] == name.upcase && row[:dataformat] == "Percent" && row[:poverty_level] == "Eligible for Free or Reduced Lunch"
        return row[:data].to_f
      else
        next
      end
    end
    output_changer(output)
  end

  def lunch_number_selector(data, year)
    output = data.select do |row|
      if row[:timeframe].to_i == year && row[:location] == name.upcase && row[:dataformat] == "Number" && row[:poverty_level] == "Eligible for Free or Reduced Lunch"
        return row[:data].to_f
      else
        next
      end
    end
    output_changer(output)
  end

  def selector(data, year)
    output = data.select do |row|
      if row[:timeframe].to_i == year && row[:location] == name.upcase && row[:dataformat] == "Percent"
        return row[:data]
      else
        next
      end
    end
    output_changer(output)
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

  def is_output_valid?(input)
    if input == 0.0 || input == nil
      raise UnknownDataError
    else
      return input
    end
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
