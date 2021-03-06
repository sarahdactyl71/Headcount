require 'CSV'
require_relative 'enrollment'
require_relative 'helper_module'
require "pry"

class EnrollmentRepository

  include Helper

  def find_by_name(input)
    Enrollment.new({:name => input,
                      :kindergarten_participation => kindergarten_info(input),
                      :high_school_graduation => high_school_info(input)
                      })
  end

  def kindergarten_info(input)
    info = {}
    emergency_loader
    @kg_key.each do |row|
      if row[:location] == input.upcase
        info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
  end

  def high_school_info(input)
    info = {}
    emergency_loader
    @hs_key.each do |row|
      if row[:location] == input.upcase
        info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
  end


end
