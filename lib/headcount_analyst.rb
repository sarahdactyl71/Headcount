require "pry"
require_relative "enrollment_repository"

class HeadcountAnalyst

  attr_reader :district_repository

  def initialize(district_repository)
    @district_repository = district_repository
    @info = {
  :enrollment => {
    :kindergarten => "./test/fixtures/Kindergarten_sample_data.csv"
  }}
  end

  def load_data(args)
    data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
  end

  def data_cleaner ;end

  def kindergarten_participation_rate_variation(district, comparison)

  end

  def year_and_rate(input)
    info = {}
    @data.each do |row|
      if row[:location] == input.upcase
        info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
  end

end
