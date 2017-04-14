require "pry"
require_relative 'district_repository'

class District
attr_reader :name, :repo

  def initialize(args)
    @name = args[:name]
    @repo = args[:repo]
  end

  def enrollment
    distrepo = repo
    current_name = name
    distrepo.enrollment_repository.find_by_name(current_name)
  end

end

# binding.pry
# ""
