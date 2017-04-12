require_relative "enrollment_repository"
require 'pry'

class Enrollment

attr_reader :name, :kindergarten_participation

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
  end

  def kindergarten_participation_by_year

  end

  def kindergarten_participation_in_year(year)
  end

end
