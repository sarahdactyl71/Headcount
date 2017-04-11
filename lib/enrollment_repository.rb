require 'CSV'
require './lib/enrollment'
require "pry"

class EnrollmentRepository
attr_reader :data, :enrollments

  def initialize
    @enrollments = []
  end


  def load_data(args)
    CSV.foreach(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      enrollments << Enrollment.new(row)
    end
  end

  def find_by_name(input)
    enrollments.find do |enrollment|
      enrollment.name == input.upcase
    end
  end
  
end

# binding.pry
# ""
