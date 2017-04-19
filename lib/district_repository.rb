require "csv"
require_relative 'district'
require_relative 'enrollment_repository'
require_relative 'economic_profile_repository'
require_relative 'helper_module'
require "pry"

class DistrictRepository
include Helper
attr_reader :data,
            :districts,
            :enrollment_repository,
            :statewide_test

  def initialize
    @districts = []
    @enrollment_repository = EnrollmentRepository.new
    @statewide_test = StatewideTestRepository.new
    @economic_repository = EconomicProfileRepository.new
  end
  #
  # def load_data(args)
  #   data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
  #   enrollment_repository.load_data(args)
  #   build_districts(data)
  # end

  def build_districts(data)
    data.each do |row|
      districts << District.new({name: row[:location], repo: self})
    end
  end

  def find_by_name(input)
    build_districts(@data_key)
    districts.find do |district|
      district.name == input.upcase
    end
  end

  def find_all_matching(input)
    matches = districts.find_all do |district|
      district.name.include?(input)
    end
    matches.map! {|district| district.name}
    matches.uniq
  end
end
