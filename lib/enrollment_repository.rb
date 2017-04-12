require 'CSV'
require_relative 'enrollment'
require "pry"

class EnrollmentRepository
attr_reader :data, :enrollments

  def initialize
    @enrollments = []
  end

  def load_data(args)
    @data = CSV.open(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol)

  end
  # def load_data(args)
  #   CSV.foreach(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
  #     enrollments << Enrollment.new({name: row[:location], :kindergarten_participation => nil})
  #   end
  # end

  def find_by_name(input)
    Enrollment.new({:name => input, :kindergarten_participation => kindergarten_info(input)})
  end

  def kindergarten_info(input)
    data = {}
    @data.each do |row|
      if row[:location] == input.upcase
        data[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    data
  end
end

# binding.pry
# ""
