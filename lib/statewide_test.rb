require 'CSV'
require "pry"
require_relative "enrollment_repository"
require_relative "state_wide_test"
require_relative "helper_module"

class StatewideTestRepository
include Helper

  def find_by_name(input)
    StatewideTest.new({:name => input,
                        :third_grade_info => @tg_key,
                        :eighth_grade_info => @eg_key,
                        :math => @math_key,
                        :reading => @read_key,
                        :writing => @write_key
                        })
  end

end
