require "csv"
require './lib/finder_module'
require "pry"

class DistrictRepository
include Finder
attr_reader :data

  def load_data(args)
    enrollment = args[:enrollment]
    # kindergarten = enrollment[:kindergarten]
    @data = CSV.open args(kindergarten, headers: true, header_converters: :symbol)
  end

end

dr = DistrictRepository.new
dr.load_data("./data/Kindergartners in full-day program.csv")
