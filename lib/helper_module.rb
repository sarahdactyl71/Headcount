module Helper

  attr_reader :hs_key, :kg_key

  def truncate(value)
    (value.to_f*1000).floor/1000.0
  end

  def load_data(args)
    args[:enrollment].keys.each do |key|
      if key == :high_school_graduation
        @hs_key = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
      else
        @kg_key = CSV.open(args[:enrollment][key], headers: true, header_converters: :symbol)
      end
    end
  end

end
