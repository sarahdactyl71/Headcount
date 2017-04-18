gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_test'
require './lib/state_wide_test'

class StateWideTestTest < Minitest::Test
  attr_reader :std,
              :state_test

  def setup
    @std = StatewideTestRepository.new
    std.load_data({
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
      })
      @state_test = std.find_by_name('ACADEMY 20')
  end

    def test_find_name
        assert_instance_of StateWideTest, state_test = std.find_by_name('ACADEMY 20')
        output = { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
          2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
          2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
          2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
          2012 => {:math => 0.83, :reading => 0.87, :writing => 0.655},
          2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
          2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}
        }
        assert_equal output, state_test.proficient_by_grade(3)
    end

    def test_proficient_by_race_returns_correct_hash
      output = { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
     2012 => {math: 0.818, reading: 0.893, writing: 0.808},
     2013 => {math: 0.805, reading: 0.901, writing: 0.810},
     2014 => {math: 0.800, reading: 0.855, writing: 0.789},
      }
      assert_equal output, state_test.proficient_by_race_or_ethnicity(:asian)
    end

    def test_proficient_for_subject_by_grade_in_year_and_race
      assert_equal 0.857, state_test.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
      assert_equal 0.818, state_test.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
    end

    def test_stuff
      @state_test = std.find_by_name('PLATEAU VALLEY 50')
      assert_equal "N/A", state_test.proficient_for_subject_by_grade_in_year(:reading, 8, 2011)
    end
  end
