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
    @math = args[:math]
    @reading = args[:reading]
    @writing = args[:writing]
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

  def proficient_by_race_or_ethnicity(race)
    @compiled_math = csap_compiler(race, @math)
    @compiled_reading = csap_compiler(race, @reading)
    @compiled_writing = csap_compiler(race, @writing)
    csap_years(compiled_math)
    csap_hash(csap_years(compiled_info), compiled_info)
  end

  def csap_compiler(race, key)
    csap = []
    # keys = [@math, @reading, @writing]
      key.select do |row|
        if row[:race_ethnicity].downcase.to_sym == race && row[:location] == @name.upcase
          csap << row
        end
      end
    csap
  end

  def csap_years(data)
    years = []
    data.map do |row|
      if row.class == Fixnum
        next
      else
        years << row[:timeframe]
      end
    end
    years
  end

  def csap_hash(years, compiled_info)
      output = {}
      years.each do |year|
        info = {}
        compiled_info.map do |row|
          binding.pry

          end
          to_merge = { year => info }
          output.merge!(to_merge)
          # if row[:timeframe].to_i == year
          # info[row[:score].downcase.to_sym] = truncate(row[:data])
          # end
        end
      output
      binding.pry
    # data.each do |index|
    #   index.map do |data|
    # results = data.group_by do  |x|
    #  x.to_s.split.to_a[4]
    # end
    # binding.pr
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
    output = {}
    years.uniq.each do |year|
      info = {}
      compiled_info.map do |row|
        if row[:timeframe].to_i == year
        info[row[:score].downcase.to_sym] = truncate(row[:data])
        end
      end
      to_merge = { year => info }
      output.merge!(to_merge)
    end
    output
  end

end
