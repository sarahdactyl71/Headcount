require "pry"
require_relative 'district_repository'

class District
attr_reader :name

  def initialize(args)
    @name = args[:name]
  end

  def enrollment
  
  end

end
