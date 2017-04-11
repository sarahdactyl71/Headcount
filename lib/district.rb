require "pry"

class District
attr_reader :name

  def initialize(args)
    @name = args[:location].upcase
  end

end
