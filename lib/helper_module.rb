module Helper

  attr_reader :hs_key,
              :kg_key,
              :tg_key,
              :eg_key,
              :math_key,
              :read_key,
              :write_key,
              :mhi_key,
              :cip_key,
              :forpl_key,
              :ti_key,
              :write_key,
              :name_key,
              :data_key,
              :emerg

  def truncate(value)
    (value.to_f*1000).floor/1000.0
  end

  def load_data(args)
    if args.keys[1] == :statewide_testing && args.keys[0] == :enrollment
      load_statewide(args)
      load_enrollment(args)
    elsif args.keys[0] == :statewide_testing
      load_statewide(args)
    elsif args.keys[0] == :enrollment
      load_enrollment(args)
    elsif args.keys[0] == :economic_profile
      load_economic_profile(args)
    end
  end

  def load_enrollment(args)
    args[:enrollment].keys.each do |key|
      if key == :high_school_graduation && @hs_key == nil
        hs_key = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
        @hs_key = hs_key.to_a
      elsif key == :kindergarten && @kg_key == nil
        kg_key = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
        @kg_key = kg_key.to_a
      end
      data_key = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
      @data_key = data_key.to_a
    end
  end

  def load_statewide(args)
    args[:statewide_testing].keys.each do |key|
      if key == :third_grade
        tg_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
        @tg_key = tg_key.to_a
      elsif key == :eighth_grade
        eg_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
        @eg_key = eg_key.to_a
      elsif key == :math
        math_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
        @math_key = math_key.to_a
      elsif key == :reading
        read_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
        @read_key = read_key.to_a
      elsif key == :writing
        write_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
        @write_key = write_key.to_a
      end
    end
  end

  def load_economic_profile(args)
    args[:economic_profile].keys.each do |key|
      if key == :median_household_income
        mhi_key = CSV.open(args[:economic_profile][key], headers: true, header_converters: :symbol)
        @mhi_key = mhi_key.to_a
      elsif key == :children_in_poverty
        cip_key = CSV.open(args[:economic_profile][key], headers: true, header_converters: :symbol)
        @cip_key = cip_key.to_a
      elsif key == :free_or_reduced_price_lunch
        forpl_key = CSV.open(args[:economic_profile][key], headers: true, header_converters: :symbol)
        @forpl_key = forpl_key.to_a
      elsif key == :title_i
        ti_key = CSV.open(args[:economic_profile][key], headers: true, header_converters: :symbol)
        @ti_key = ti_key.to_a
      elsif key == :name
        name_key = CSV.open(args[:economic_profile][key], headers: true, header_converters: :symbol)
        @name_key = name_key.to_a
      end
    end
  end

  def emergency_loader
    if @kg_key == nil || @hs_key == nil
      emergency_info
    end
  end

  def emergency_info
    @emerg = {:enrollment => {
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
    load_data(@emerg)
  end

  def output_changer(output)
      if output = []
        return 0.0
      else
        return output
      end
  end

  def is_output_valid?(input)
    if input == 0.0 || input == nil
      return "N/A"
    else
      return input
    end
  end

  def is_it_valid?(input)
    valid_entry = [:math, :reading, :writing, 3, 8]
     if valid_entry.include?(input) == false
       puts "InsufficientInformationError: A grade must be provided to answer this question"
     else
       input
     end
  end

  def second_stage_validator(grade, subject = nil)
    is_it_valid?(subject)
    is_it_valid?(grade)
    if grade == 3
      @key = data_cleaner(@tg_key)
    elsif grade == 8
      @key = data_cleaner(@eg_key)
    end
  end

  def data_cleaner(input)
    corrupt_info = []
    output = []
    input.each do |row|
      if row[:data].to_f == 0.0
        corrupt_info << row
      else
        output << row
      end
    end
    output
  end


end
