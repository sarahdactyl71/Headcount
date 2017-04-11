require_relative "enrollment_repository"
require 'pry'

class Enrollment
attr_reader :name
  def initialize(args)
    @name = args[:location].upcase
    # @years = args[:timeframe][:data]
    binding.pry
  end
  #i want to instantiate a class of Enrolloment that
  #takes in two things: a name of district years of participation

  def kindergarten_participation_by_year
  end

  def kindergarten_participation_in_year(year)
  end

end
