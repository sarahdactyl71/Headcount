require_relative "statewidetestrepository"
require_relative "helper_module"
require 'pry'

class StateWideTest
  include Helper
  attr_reader :name,
              :key

  def initialize(args)
    @name = args[:name]
    @third_grade_info = args[:third_grade_info]
    @eighth_grade_info = args[:eighth_grade_info]
  end

  def proficiency_by_grade(input)
    if input == 3
      @key = @third_grade_info
    elsif  input == 8
      @key = @eighth_grade_info
    end
    compiler = compiler(input, @key)
    hash_creator(hash_years(compiler), compiler)
  end

  def compiler(input, key)
    compiler = []
    key.select do |row|
      if row[:location] == @name.upcase
        compiler << row
      end
    end
    compiler
  end

  def hash_years(input)
    years = []
    input.select do |row|
      years << row[:timeframe].to_i
    end
    years
  end

  def hash_creator(years, compiled_info)
    info = {}
    output = {}
    years.uniq.each do |year|
      compiled_info.map do |row|
        if row[:timeframe].to_i == year
        info[row[:score].downcase.to_sym] = row[:data].to_f
        end
      end
      # output[year] = info
      # output.store(year, info)
      to_merge = { year => info }
      output.merge!(to_merge)
    end
    binding.pry
  end

end
