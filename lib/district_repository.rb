require "csv"
require './lib/district'
require "pry"

class DistrictRepository
# include Finder
attr_reader :data, :districts

  def initialize
    @districts = {}
  end

  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
    district_list(data)
  end


  def find_by_name(input)
    binding.pry
    data.map do |row|
      if row[:location] == input
        district = District.new(row)
          binding.pry

      end
    end
  end

  def district_list(input)
    districts = data.map do |row|
      row[:location]
    end
  end

end
