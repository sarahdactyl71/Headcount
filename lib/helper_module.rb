module Helper

  attr_reader :hs_key,
              :kg_key,
              :tg_key,
              :eg_key,
              :math_key,
              :read_key,
              :write_key

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
    end
  end

  def load_statewide(args)
    args[:statewide_testing].keys.each do |key|
      if key == :third_grade
        @tg_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
      elsif key == :eighth_grade
        @eg_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
      elsif key == :math
        @math_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
      elsif key == :reading
        @read_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
      elsif key == :writing
        @write_key = CSV.open(args[:statewide_testing][key], headers: true, header_converters: :symbol)
      end
    end
  end

end
