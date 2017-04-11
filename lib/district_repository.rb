require "csv"
require './lib/district'
require "pry"

class DistrictRepository
# include Finder
attr_reader :data, :districts, :district_list

  def initialize
    @districts = {}
  end

  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
    @districts = district_list(data)
  end

  def find_by_name(input)
    search = input.upcase
    final_results = []
    @districts.each do |district|
      names = district.name.upcase
      if names == search
        final_results << district
      end
    end
    final_results
  end

  def district_list(input)
    list = input.map do |object|
      name = object[:location]
      object = District.new(name)
    end
  end

end
