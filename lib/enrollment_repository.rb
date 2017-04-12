require 'CSV'
require_relative 'enrollment'
require "pry"

class EnrollmentRepository
attr_reader :data, :enrollments

  def initialize
    @enrollments = []
  end

  def load_data(args)
    data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)
    build_districts(data)
    binding.pry
  end
  # def load_data(args)
  #   CSV.foreach(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
  #     enrollments << Enrollment.new({name: row[:location], :kindergarten_participation => nil})
  #   end
  # end

  def find_by_name(input)
    enrollments.find do |enrollment|
      enrollment.name == input.upcase
    end
  end

  def kindergarten_info
    temp_data = {}
    enrollments.each do |line|
      temp_data[line[:timeframe].to_i] = line[:data].to_f
    end
    binding.pry
    temp_data
  end
end

# binding.pry
# ""
