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
    @kg_key.each do |row|
      if row[:location] == input.upcase
        info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
    info
  end

  def high_school_info(input)
    info = {}
    if @hs_key == nil
      kindergarten_info(input)
    else
    @hs_key.each do |row|
      if row[:location] == input.upcase
        info[row[:timeframe].to_i] = row[:data].to_f
      end
    end
  end
    info
  end

end

  # def load_data(args)
  #   CSV.foreach(args[:enrollment][:kindergarten], headers: true, header_converters: :symbol) do |row|
  #     enrollments << Enrollment.new({name: row[:location], :kindergarten_participation => nil})
  #   end
  # end
