require 'CSV'
require './lib/enrollment'
require "pry"

class EnrollmentRepository
attr_reader :data

  def load_data(args)
    @data = CSV.open args[:enrollment][:kindergarten], headers: true, header_converters: :symbol
  end

  def find_by_name(input)
    data.each do |row|
      if row[:location] == input.upcase
        enrollments = Enrollment.new(row)
        return enrollments
      end
    end
  end

end
