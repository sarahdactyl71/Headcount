require_relative "enrollment_repository"
require 'pry'

class Enrollment

attr_reader :name, :kindergarten_participation

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
  end

  # Goal 1: Build an array of these... {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}
  # all_enrollment_data = []
  # CSV.foreach do |row|
  #   For each row
  #   Check if the name is already present
  #   If name is not present
  #     Add a new hash with a key of name that points to the location
  #   Always Add the year as a key under the kindergarten_participation hash with a value of enrollment rate as a percentage
  #  Goal 2: After the array of hashes is complete we need to iterate over the array and return an array of Enrollment objects
  def kindergarten_participation_by_year
    kindergarten_participation.each_pair do |key, value|
      kindergarten_participation[key] = (value.to_f*1000).floor/1000.0
    end
    binding.pry
  end

  def kindergarten_participation_in_year(year)
  end
end
