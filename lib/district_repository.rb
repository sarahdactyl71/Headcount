require "csv"
require './lib/finder_module'
require "pry"

class DistrictRepository
include Finder
attr_reader :data

  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
  end

  def find_by_name(name)
    @data.each do |row|
      district_name = row[:Location]
    if name.upcase == district_name
      puts 

end
