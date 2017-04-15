require 'CSV'
require "pry"
require_relative "enrollment_repository"
require_relative "helper_module"

class HeadcountAnalyst

  include Helper

  attr_reader :district_repository, :info

  def initialize(district_repository)
    @district_repository = district_repository
    @info = {
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv",
    :high_school_graduation => "./data/High school graduation rates.csv"
  }}
  end

  def load_data(args)
    args[:enrollment].keys.each do |key|
      if key == :high_school_graduation
        @hs_key = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
      else
        @kg_key = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
      end
    end
  end
  # def load_data(args)
  #   @data = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
  # end

  def data_cleaner ;end

  def kindergarten_participation_rate_variation(district, comparison)
    comparison = comparison.values[0]
    district_info = year_and_rate(district)
    district = collect_participation(district_info)
    comparison_info = year_and_rate(comparison)
    comparison = collect_participation(comparison_info)
    output = (district/comparison)
    truncate(output)
  end

  def kindergarten_participation_rate_variation_trend(district, comparison)
    comparison = comparison.values[0]
    district_info = year_and_rate(district)
    comparison_info = year_and_rate(comparison)
    output = comparison_info.merge(district_info) { |key, old_val, new_val| truncate((new_val / old_val)) }
    output
  end

  def kindergarten_participation_against_high_school_graduation(district)
    state_trend = year_and_rate('Colorado')
    state_sum = collect_participation(state_trend)
    kg_trend = year_and_rate(district)
    kg_sum = collect_participation(kg_trend)
    hs_trend = year_and_rate_highschool(district)
    hs_sum = collect_participation(hs_trend)
    output = truncate((kg_sum/state_sum)/(hs_sum/state_sum))
  end

  def year_and_rate(input)
    load_data(info)
    info = {}
    @kg_key.each do |row|
      if row[:location].upcase == input.upcase
         info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
  end

  def year_and_rate_highschool(input)
    load_data(info)
    info = {}
    @hs_key.each do |row|
      if row[:location].upcase == input.upcase
         info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
  end

  def collect_participation(info)
    participation = []
    output = info.to_a
    output.map do |index|
      index.map do |value|
        if value.class == Float
          participation << value
        end
      end
    end
    participation_average(participation)
  end

  def participation_average(input)
    sum = input.reduce(0) { |a, value| a + value }
    output = sum/(input.count)
  end

end
