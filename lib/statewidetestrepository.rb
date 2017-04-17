require 'CSV'
require "pry"
require_relative "enrollment_repository"
require_relative "statewidetest"
require_relative "helper_module"

class StateWideTestRepository
include Helper

  def find_by_name(input)
    StateWideTest.new({:name => input, :third_grade => third_grade_info(input), :eighth_grade => eighth_grade_info(input)})
  end


  def third_grade_info(input)
    compiler = []
    @tg_key.select do |row|
      if row[:location] == input.upcase
        compiler << row
      end
    end
    hash_creator(compiler)
  end

  def hash_creator(input)
    binding.pry
  end
end
