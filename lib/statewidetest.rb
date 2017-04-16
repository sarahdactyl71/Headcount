require_relative "statewidetestrepository"
require_relative "helper_module"
require 'pry'

class StateWideTest
  include Helper
  attr_reader :name,
              :third_grade,
              :eighth_grade

  def initialize(args)
    @name = args[:name]
    @third_grade = args[:third_grade]
    @eighth_grade = args [:eighth_grade]
  end

  
end
