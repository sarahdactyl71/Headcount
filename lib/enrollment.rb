require_relative "enrollment_repository"
require 'pry'

class Enrollment

attr_reader :name, :kindergarten_participation, :high_school_graduation

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
    @high_school_graduation = args[:high_school_graduation]
  end

  def kindergarten_participation_by_year
    kindergarten_participation.each_pair do |key, value|
      kindergarten_participation[key] = (value.to_f*1000).floor/1000.0
    end
  end

  def kindergarten_participation_in_year(year)
    ouput = kindergarten_participation[year]
    output = (ouput.to_f*1000).floor/1000.0
    return output
  end

  def graduation_rate_by_year
    high_school_graduation.each_pair do |key, value|
      high_school_graduation[key] = (value.to_f*1000).floor/1000.0
    end
  end

  def graduation_rate_in_year(year)
  end

end
