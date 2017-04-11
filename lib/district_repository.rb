require "csv"
require_relative 'district'
require "pry"

class DistrictRepository
attr_reader :data, :districts

  def initialize
    @districts = []
  end

  def load_data(args)
    CSV.foreach(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      districts << District.new(row)
    end
  end

  def find_by_name(input)
    districts.find do |district|
      district.name == input.upcase
    end
  end

end
