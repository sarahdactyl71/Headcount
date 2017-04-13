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
  end

  def year_and_rate(input)
    load_data(info)
    binding.pry
    info = {}
    @data.each do |row|
      if row[:location] == input.upcase
        info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
  end

end