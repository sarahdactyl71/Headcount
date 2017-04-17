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
    key = @tg_key
    compiler = compiler (input, key)
    hash_creator(compiler)
  end

  def eighth_grade_info(input)
    key = @eg_key
    compiler = compiler(input, key)
    hash_creator(compiler)
  end

  def compiler(input, key)
    compiler = []
    key.select do |row|
      if row[:location] == input.upcase
        compiler << row
      end
    end
  end

  def hash_creator(input)
    years = []
    info = {}
    output = {}
    input.select do |row|
      years << row[:timeframe].to_i
    end
    years.uniq.each do |year|
      input.map do |row|
        if row[:timeframe].to_i == year
        info[row[:score].downcase.to_sym] = row[:data]
      end
    end
    output.merge!({year => info})
  end
  end

end
