require "pry"

class HeadcountAnalyst

  attr_reader :district_repository

  def initialize(district_repository)
    @district_repository = district_repository
  end

end
