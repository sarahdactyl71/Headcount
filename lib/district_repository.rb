require "csv"
require './lib/district'
require "pry"

class DistrictRepository
# include Finder
attr_reader :data, :districts

  def initialize
    @districts = []
  end

  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
  end


  def find_by_name(input)
    data.each do |row|
      if row[:location] == input.upcase
        district = District.new(row)
      end
    end
  end

end
