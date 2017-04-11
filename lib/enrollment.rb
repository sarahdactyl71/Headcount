class Enrollment
attr_reader :name
  def initialize(args)
    @name = args[:location].upcase
  end
  #
  # def kindergarten_participation_by_year
  # end
  # 
  # def kindergarten_participation_in_year(year)
  # end

end
