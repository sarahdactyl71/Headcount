require 'CSV'
require "pry"
require_relative "enrollment_repository"

class HeadcountAnalyst

  attr_reader :district_repository, :info

  def initialize(district_repository)
    @district_repository = district_repository
<<<<<<< HEAD
    @info = {:enrollment => {:kindergarten => "./test/fixtures/Kindergarten_sample_data.csv"}}
=======
    @info = {
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv"
  }}
>>>>>>> 9e2aa3f2869061ec0026a5de4d9ac4e4abb1939f
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
    info = {}
    @data.each do |row|
      if row[:location] == input.upcase
         info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
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
    binding.pry
  end


end
