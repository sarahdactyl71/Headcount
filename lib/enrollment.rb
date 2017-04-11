require_relative "enrollment_repository"
require 'pry'

class Enrollment
attr_reader :name
  def initialize(args)
    @name = args[:location].upcase
    @kindergarten_participation = args[:timeframe][:data]
  end

  def kindergarten_participation_by_year
    binding.pry
    data.each do |row|
      if row[:location] == input.upcase
         @kindergarten_participation= Enrollment.new(row)
        return enrollment
        @kindergarten_participation << enrollment
      end
    end

  end

  def kindergarten_participation_in_year(year)
  end

end
