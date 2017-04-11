require "csv"
require './lib/finder_module'
require "pry"

class DistrictRepository
include Finder
attr_reader :data

  def load_data(args)
    @data = CSV.open args, headers: true, header_converters: :symbol
    binding.pry
  end

end

dr = DistrictRepository.new
dr.load_data("./data/Kindergartners in full-day program.csv")
