require_relative "enrollment_repository"
require 'pry'

class Enrollment

attr_reader :name, :kindergarten_participation

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
  end


  def kindergarten_participation_by_year
    kindergarten_participation.each_pair do |key, value|
      kindergarten_participation[key] = (value.to_f*1000).floor/1000.0
    end
  end

  def kindergarten_participation_in_year(year)
    return kindergarten_participation[year]
  end

end
