gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test
  def test_init
    er = EnrollmentRepository.new
    assert_instance_of EnrollmentRepository, er
  end

  def test_load_data
    er = EnrollmentRepository.new
    er.load_data({
        :enrollment => {
          :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    enrollment = er.find_by_name("academy 20")
    assert_equal "ACADEMY 20", enrollment.name
    end

  def test_load_data_two
    skip
    er = EnrollmentRepository.new
    er.load_data({
        :enrollment => {
          :kindergarten => "./data/Kindergartners in full-day program.csv"
        }
      })
    enrollment = er.find_by_name("JOHNSTOWN-MILLIKEN RE-5J")
    assert_equal "JOHNSTOWN-MILLIKEN RE-5J", enrollment.name
    end
end
