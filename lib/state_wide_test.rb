require_relative "statewide_test"
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
    what_key?(input)
    compiler = compiler(@key)
    hash_creator(hash_years(compiler), compiler)
  end

  def proficient_by_race_or_ethnicity(race)
    @compiled_math = csap_compiler(race, @math)
    @compiled_reading = csap_compiler(race, @reading)
    @compiled_writing = csap_compiler(race, @writing)
    csap_hash(csap_years(@compiled_math))
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    what_key?(grade)
    compiler = compiler(@key)
    info_for_subject_by_grade(compiler, subject, year)
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    if subject.to_s == "math"
      compiled_math = csap_compiler(race, @math)
      truncate(info_for_subject_by_race(compiled_math, subject, year))
    elsif subject.to_s == "reading"
      compiled_reading = csap_compiler(race, @reading)
      truncate(info_for_subject_by_race(compiled_reading, subject, year))
    elsif subject.to_s == "writing"
      compiled_writing = csap_compiler(race, @writing)
      truncate(info_for_subject_by_race(compiled_writing, subject, year))
    end
  end

  def what_key?(input)
    if input == 3
      @key = @third_grade_info
    elsif  input == 8
      @key = @eighth_grade_info
    end
  end

  def info_for_subject_by_grade(data, subject, year)
    data.map do |row|
      if row[:score].downcase == subject.to_s && row[:timeframe].to_i == year
        return row[:data].to_f
      end
    end
  end

  def info_for_subject_by_race(data, subject, year)
    data.map do |row|
      if row[:timeframe].to_i == year
        return row[:data].to_f
      end
    end
  end

  def csap_hash(years)
    years.each do |year|
      math = compile_math_hash(@compiled_math, years)
      reading = compile_reading_hash(@compiled_reading, math)
      writing = compile_writing_hash(@compiled_writing, reading)
      return writing
    end
  end


  def csap_compiler(race, key)
    csap = []
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
        years << row[:timeframe].to_i
      end
    end
    years
  end


  def compile_writing_hash(rows, reading)
    reading.each_pair do |year, hash|
      info = {}
      rows.map do |row|
        if row[:timeframe].to_i == year
          info["writing".downcase.to_sym] = truncate(row[:data])
        end
        hash.merge!(info)
      end
    end
    reading
  end

  def compile_reading_hash(rows, math)
    math.each_pair do |year, hash|
      info = {}
      rows.map do |row|
        if row[:timeframe].to_i == year
          info["reading".downcase.to_sym] = truncate(row[:data])
        end
        hash.merge!(info)
      end
    end
    math
  end

  def compile_math_hash(rows, years)
  output = {}
  years.each do |year|
    info = {}
    rows.map do |row|
      if row[:timeframe].to_i == year
        info["math".downcase.to_sym] = truncate(row[:data])
      end
      to_merge = { year => info }
      output.merge!(to_merge)
      end
    end
    output
  end

  def compiler(key)
  compiler = []
    key.select do |row|
      if row[:location] == @name.upcase
        compiler << row
      end
    end
  return compiler
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
