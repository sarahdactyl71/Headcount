require "csv"
require_relative 'district'
require_relative 'enrollment_repository'
require "pry"

class DistrictRepository
attr_reader :data,
            :districts,
            :enrollment_repository

  def initialize
    @districts = []
    @enrollment_repository = EnrollmentRepository.new
  end

  def load_data(args)
    data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
    enrollment_repository.load_data(args)
    build_districts(data)
  end

  def build_districts(data)
    data.each do |row|
      districts << District.new({name: row[:location], repo: self})
    end
    binding.pry
  end

  def find_by_name(input)
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


  # def load_data(args)
  #   CSV.foreach(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
  #     districts << District.new({name: row[:location]})
  #   end
  # end
