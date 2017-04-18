require 'CSV'
require "pry"
require_relative "economic_profile"
require_relative "helper_module"

class EconomicProfileRepository

  include Helper

  def find_by_name(input)
    EconomicProfile.new({:median_household_income => @mhi_key,
                        :children_in_poverty => @cip_key,
                        :free_or_reduced_price_lunch => @forpl_key,
                        :title_i => @ti_key,
                        :name => input,
                        })
  end


end
