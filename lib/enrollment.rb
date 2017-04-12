require_relative "enrollment_repository"
require 'pry'

class Enrollment

<<<<<<< HEAD
attr_reader :name, :kindergarten_participation
=======
attr_reader :name
>>>>>>> 7b2dc79a53b95fc9a32d7f34a01391ba8c4ed9fa

  def initialize(args)
    @name = args[:name]
    @kindergarten_participation = args[:kindergarten_participation]
  end

  def kindergarten_participation_by_year

  end

  def kindergarten_participation_in_year(year)
  end

end
