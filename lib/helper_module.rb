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
              :name_key

  def truncate(value)
    (value.to_f*1000).floor/1000.0
  end

  def load_data(args)
    if args.keys[0] == :statewide_testing
      load_statewide(args)
    elsif args.keys[0] == :enrollment
      args[:enrollment].keys.each do |key|
        if key == :high_school_graduation
          @hs_key = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
        else
          @kg_key = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
        end
      end
    elsif args.keys[0] == :economic_profile
      load_economic_profile(args)
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

  def output_changer(output)
      if output = []
        return 0.0
      else
        return output
      end
  end

end
