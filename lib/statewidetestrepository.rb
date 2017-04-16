require 'CSV'
require "pry"
require_relative "enrollment_repository"
require_relative "helper_module"

class StateWideTestRepository
include Helper

  def find_by_name(input)
    StateWideTest.new({:name => input, :third_grade => third_grade_info(input), :eighth_grade => eighth_grade_info(input)})
  end


  def third_grade_info(input)
    info = {}
    @tg_key.each do |row|
      if row[:location] == input.upcase
        info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
  end

end
