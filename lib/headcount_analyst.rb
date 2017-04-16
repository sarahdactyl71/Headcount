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
    district = collect_participation(year_and_rate_kindergarten(district))
    truncate(district/comparison_kindergarden(district, comparison))
  end

  def kindergarten_participation_rate_variation_trend(district, comparison)
    district_info = year_and_rate_kindergarten(district)
    comparison_info = year_and_rate_kindergarten(comparison.values[0])
    comparison_info.merge(district_info) { |key, old_val, new_val| truncate((new_val / old_val)) }
  end

  def comparison_kindergarden(district, comparison)
    collect_participation(year_and_rate_kindergarten(comparison.values[0]))
  end

  def kindergarten_participation_against_high_school_graduation(district)
    truncate((kg_sum(district)/kg_state_sum)/(hs_sum(district)/hs_state_sum))
  end

  def kindergarten_participation_correlates_with_high_school_graduation(district)
    district = district.values[0]
    if district == 'STATEWIDE'
      create_yes_and_no_arrays
    elsif district.class == String
      single_district_correlation(district)
    elsif district.count > 1
        array = []
        district.each do |name|
          array << kindergarten_participation_against_high_school_graduation(name)
        end
        total_average = participation_average(array)/kg_state_sum
        if total_average > 0.6 && total_average < 1.5
          true
        end
    end
  end

  def create_yes_and_no_arrays
    yes = []
    no = []
    kg_and_hs_averages.each do |sum|
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
  end

  def kg_and_hs_averages
    kg_avg = kg_statewide_data.map! do |average|
      average/kg_state_sum
    end
    hs_avg = hs_statewide_data.map! do |average|
      average/hs_state_sum
    end
    kg_avg.zip(hs_avg)
  end

  def single_district_correlation(district)
    value = kindergarten_participation_against_high_school_graduation(district)
    if value > 0.6 && value < 1.5
      true
    else
      false
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

  def kg_state_sum
    collect_participation(year_and_rate_kindergarten('Colorado'))
  end

  def hs_state_sum
    collect_participation(year_and_rate_highschool('Colorado'))
  end

  def kg_sum(district)
    collect_participation(year_and_rate_kindergarten(district))
  end

  def hs_sum(district)
    collect_participation(year_and_rate_highschool(district))
  end

end
