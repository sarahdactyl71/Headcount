require_relative "enrollment_repository"
require_relative "helper_module"
require 'pry'

class Enrollment

  include Helper

attr_reader :name, :kindergarten_participation, :high_school_graduation

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
    @high_school_graduation = args[:high_school_graduation]
  end

  def kindergarten_participation_by_year
    kindergarten_participation.each_pair do |key, value|
      kindergarten_participation[key] = truncate(value)
    end
  end

  def kindergarten_participation_in_year(year)
    output = kindergarten_participation[year]
    return truncate(output)
  end

  def graduation_rate_by_year
    high_school_graduation.each_pair do |key, value|
      high_school_graduation[key] = truncate(value)
    end
  end

  def graduation_rate_in_year(year)
    output = high_school_graduation[year]
    return truncate(output)
  end

end
