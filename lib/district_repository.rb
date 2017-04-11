require "csv"
require './lib/finder_module'
require "pry"

class DistrictRepository
include Finder
attr_reader :data

  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
binding.pry
  end


end
