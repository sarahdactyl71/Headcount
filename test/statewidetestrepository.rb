gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewidetestrepository'

class StateWideTestRepositoryTest < Minitest::Test
  attr_reader :std

  def setup
    @std = StateWideTestRepository.new
    std.load_data({
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
      })
  end

  def test_init
    assert_instance_of StateWideTestRepository, std
  end
end
