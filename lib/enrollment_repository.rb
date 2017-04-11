require 'CSV'
require_relative './lib/enrollment'
require "pry"

class EnrollmentRepository
attr_reader :data, :enrollments

  def initialize
    @enrollments = []
  end
  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
  end

  def find_by_name(input)
    data.each do |row|
      if row[:location] == input.upcase
        enrollment = Enrollment.new(row)
        @enrollments << enrollment
      end
    end
    binding.pry
  end

end
