require "csv"
require './lib/district'
require "pry"

class DistrictRepository
# include Finder
attr_reader :data, :districts

  def initialize
    @districts = Hash.new
  end

  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
    # district_list(data)
  end


  def find_by_name(input)
    data.each do |row|
      if row[:location] == input.upcase
        district = District.new(row)
        return district
      end
    end
  end

  # def district_list(input)
  #   districts = data.map do |row|
  #     row[:location]
  #   end
  # end

end
