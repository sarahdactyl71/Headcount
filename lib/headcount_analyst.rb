require 'CSV'
require "pry"
require_relative "enrollment_repository"

class HeadcountAnalyst

  attr_reader :district_repository, :info

  def initialize(district_repository)
    @district_repository = district_repository
    @info = {
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }}
  end

  def load_data(args)
    @data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
  end

  def data_cleaner ;end

  def kindergarten_participation_rate_variation(district, comparison)
    comparison = comparison.values[0]
    district_info = year_and_rate(district)
    district = collect_participation(district_info)
    comparison_info = year_and_rate(comparison)
    comparison = collect_participation(comparison_info)
    output = ((district)/(comparison).to_f*1000).floor/1000.0
  end

  def kindergarten_participation_rate_variation_trend(district, comparison)
    comparison = comparison.values[0]
    district_info = year_and_rate(district)
    comparison_info = year_and_rate(comparison)
    comparison_info.merge(district_info) { |key, old_val, new_val| old_val / new_val }
    binding.pry
  end

  def year_and_rate(input)
    load_data(info)
    info = {}
    @data.each do |row|
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
