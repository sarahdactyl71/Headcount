require 'CSV'
require "pry"
require_relative "enrollment_repository"
require_relative "helper_module"

class HeadcountAnalyst

  include Helper

  attr_reader :district_repository,
              :info

  def initialize(district_repository)
    @district_repository = district_repository
    @info = {
    :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv",
    :high_school_graduation => "./data/High school graduation rates.csv"
    }}
  end

  def kindergarten_participation_rate_variation(district, comparison)
    comparison = comparison.values[0]
    district_info = year_and_rate_kindergarten(district)
    district = collect_participation(district_info)
    comparison_info = year_and_rate_kindergarten(comparison)
    comparison = collect_participation(comparison_info)
    truncate(district/comparison)
  end

  def kindergarten_participation_rate_variation_trend(district, comparison)
    comparison = comparison.values[0]
    district_info = year_and_rate_kindergarten(district)
    comparison_info = year_and_rate_kindergarten(comparison)
    output = comparison_info.merge(district_info) { |key, old_val, new_val| truncate((new_val / old_val)) }
    output
  end

  def kindergarten_participation_against_high_school_graduation(district)
    truncate((kg_sum(district)/state_sum)/(hs_sum(district)/state_sum))
  end

  def state_sum
    state_trend = year_and_rate_kindergarten('Colorado')
    collect_participation(state_trend)
  end

  def kg_sum(district)
    kg_trend = year_and_rate_kindergarten(district)
    collect_participation(kg_trend)
  end

  def hs_sum(district)
    hs_trend = year_and_rate_highschool(district)
    collect_participation(hs_trend)
  end


  def kindergarten_participation_correlates_with_high_school_graduation(district)
    district = district.values[0]
    if district == 'STATEWIDE'
      state_trend = year_and_rate_kindergarten('Colorado')
      state_sum = collect_participation(state_trend)
      kg_sum = kg_statewide_data.map! do |average|
        average/state_sum
      end
      hs_sum = hs_statewide_data.map! do |average|
        average/state_sum
      end
      combined_sum = kg_sum.zip(hs_sum)
      yes = []
      no = []
      combined_sum.each do |sum|
        outcome = (sum[0] / sum[1])
        if sum[0] == 0.0 || sum[1] == 0.0
          next
        elsif outcome > 0.6 && outcome < 1.5
          yes << outcome
        else
          no << outcome
        end
      end
      if (yes.count/no.count) < 0.7
        false
      end
    else
      value = kindergarten_participation_against_high_school_graduation(district)
      if value > 0.6 && value < 1.5
        true
      else
        false
      end
    end
  end

  def kg_statewide_data
    load_data(info)
    all_kg_districts = []
    @kg_key.each do |row|
      if row[:location] == "Colorado"
        next
      end
      all_kg_districts << row[:location]
    end
    year_data = all_kg_districts.uniq.map! do |district|
      year_and_rate_kindergarten(district)
    end
    year_data_sum = year_data.map! do |hash|
      collect_participation(hash)
    end
  end

  def hs_statewide_data
    all_hs_districts = []
    @hs_key.each do |row|
      if row[:location] == "Colorado"
        next
      end
      all_hs_districts << row[:location]
    end
    year_data = all_hs_districts.uniq.map! do |district|
      year_and_rate_highschool(district)
    end
    year_data_sum = year_data.map! do |hash|
      collect_participation(hash)
    end
  end

  def year_and_rate_kindergarten(input)
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
