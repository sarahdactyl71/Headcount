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
    @info = {:enrollment => {
                    :kindergarten => "./data/Kindergartners in full-day program.csv",
                    :high_school_graduation => "./data/High school graduation rates.csv",
                   },
                   :statewide_testing => {
                     :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
                     :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
                     :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
                     :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
                   }
                 }
    @district_growth_comparisons = {}
  end

<<<<<<< HEAD
  def top_statewide_test_year_over_year_growth(args)
    if args.count > 2
      overall_growth(args)
    elsif args.count == 1
      state_wide_growth(args)
    else
    load_data(info)
    grade = args.values[0]
    subject = args.values[1]
    is_it_valid?(subject)
    is_it_valid?(grade)
    which_grade_to_use(grade)
    compiled_info = statewide_compiler(@key, subject)
    districts = statewide_location_list(compiled_info)
    date_comparison(districts, compiled_info)
    largest?
    end
  end

  def state_wide_growth(args)
    grade = args.values[0]
    which_grade_to_use(grade)
    subjects = [:reading, :writing, :math]
    subjects.each do |subject|
      compiled_info = statewide_compiler(@key, subject)
      districts = statewide_location_list(compiled_info)
      date_comparison(districts, compiled_info)
    end
  end

  def overall_growth(args)
    load_data(info)
    grade = args.values[0]
    subject = args.values[2]
    top_number = args.values[1]
    is_it_valid?(subject)
    is_it_valid?(grade)
    which_grade_to_use(grade)
    compiled_info = statewide_compiler(@key, subject)
    districts = statewide_location_list(compiled_info)
    date_comparison(districts, compiled_info)
    output = top_number(top_number)
    return output
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
        kg_vs_hs = []
        district.each do |name|
          kg_vs_hs << kindergarten_participation_against_high_school_graduation(name)
        end
        final = kg_vs_hs.map! do |number|
          if number > 0.6 && number < 1.5
            number
          else
            kg_vs_hs.delete(number)
          end
        end
        if ((final.count/kg_vs_hs.count)) >= 0.70
          true
        else
          false
        end
    end
  end

  def top_statewide_test_year_over_year_growth(args)
    if args.count > 2
      overall_growth(args)
    elsif args.count == 1
      state_wide_growth(args)
    else
    load_data(info)
    grade = args.values[0]
    subject = args.values[1]
    second_stage_validator(grade, subject)
    compiled_info = statewide_compiler(@key, subject)
    districts = statewide_location_list(compiled_info)
    date_comparison(districts, compiled_info)
    largest?
    end
  end

  def overall_growth(args)
    load_data(info)
    grade = args.values[0]
    subject = args.values[2]
    top_number = args.values[1]
    second_stage_validator(grade, subject)
    compiled_info = statewide_compiler(@key, subject)
    districts = statewide_location_list(compiled_info)
    date_comparison(districts, compiled_info)
    output = top_number(top_number)
    return output
  end


  def state_wide_growth(args)
    grade = args.values[0]
    second_stage_validator(grade, :math)
    subjects = [:reading, :writing, :math]
    subjects.each do |subject|
      compiled_info = statewide_compiler(@key, subject)
      districts = statewide_location_list(compiled_info)
      date_comparison(districts, compiled_info)
    end
  end

  def largest?
    @district_growth_comparisons.max_by{|k,v| v}
  end


  def top_number(input)
    top_numbers = []
    input.times do |i|
      remove = @district_growth_comparisons.max_by{|k,v| v}
      top_numbers << remove
      @district_growth_comparisons.delete(remove[0])
    end
    return top_numbers
  end

  def date_comparison(district, data)
    district.each do |location|
      @districts = []
      data.map do |row|
          if row[:location] == "Colorado"
            next
          elsif row[:location] == location.upcase
            @districts << row
          end
      end
    date_comparitor(@districts, location)
    end
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

  def date_comparitor(input, location)
    first = input.first[:data].to_f
    last = input.last[:data].to_f
    years = ((input.count) - 1)
    # if location ==  "WILEY RE-13 JT"
    #   binding.pry
    # end
    if years == 0
      years = 1
    end
      growth = truncate(((last - first) / years).abs)
      to_add = { location => growth}
      @district_growth_comparisons.merge!(to_add)
  end

  def statewide_compiler(key, subject)
    csap = []
      key.select do |row|
        if row[:score].downcase.to_sym == subject
          csap << row
        end
      end
    return csap
  end

  def statewide_location_list(input)
    output = []
    input.map do |row|
      if row[:location] == "Colorado"
        next
      else
      output << row[:location]
      end
    end
    output.uniq
  end

  def create_yes_and_no_arrays
    yes = []
    no = []
    load_data(info)
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
