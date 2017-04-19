require "pry"
require_relative 'district_repository'
require_relative 'state_wide_test'

class District
attr_reader :name,
            :repo

  def initialize(args)
    @name = args[:name]
    @repo = args[:repo]
  end

  def enrollment
    distrepo = repo
    current_name = name
    distrepo.enrollment_repository.find_by_name(current_name)
  end

  def statewide_test
    distrepo = repo
    current_name = name
    distrepo.statewide_test.find_by_name(current_name)
  end

  def economic_profile
    distrepo = repo
    current_name = name
    distrepo.economic_repository.find_by_name(current_name)
  end
  
end
