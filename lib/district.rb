class District
attr_reader :name

  def initialize(args)
    @name = args[:location]
  end

end
