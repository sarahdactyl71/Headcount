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

  def kindergarten_participation_rate_variation(district, args)
    year_and_rate(district)
    year_and_rate(comparison)
    output = (year_and_rate(district))/(year_and_rate(comparison))
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
    collect_participation(info)
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
