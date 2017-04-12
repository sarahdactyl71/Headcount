require 'CSV'
require_relative 'enrollment'
require "pry"

class EnrollmentRepository
attr_reader :data, :enrollments

  def initialize
    @enrollments = []
  end


  def load_data(args)
    CSV.foreach(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
      enrollments << Enrollment.new({name: row[:location]})
    end
  end

  def find_by_name(input)
    enrollments.find do |enrollment|
      enrollment.name == input.upcase
    end
  end

  # enrollments << Enrollment.new({name: row[:location], kindergarten_participation: {}})
  # Goal 1: Build an array of these... {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}
  # all_enrollment_data = []
  # CSV.foreach do |row|
  #   For each row
  #   Check if the name is already present
  #   If name is not present
  #     Add a new hash with a key of name that points to the location
  #   Always Add the year as a key under the kindergarten_participation hash with a value of enrollment rate as a percentage
  #  Goal 2: After the array of hashes is complete we need to iterate over the array and return an array of Enrollment objects

  def add_kindergarten_participation_data(dates)
    # all_enrollment_data = []
    # CSV.foreach(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
    #   if @enrollme
  end


end

# binding.pry
# ""
