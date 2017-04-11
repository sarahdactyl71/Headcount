require 'csv'
require 'pry'

module LoadData
  #Load data into the program to be accessed from other places
  #use what I learned from the event manager to do this
  #
  def says_hi
    "Hello"
  end

  def load_data(data_kind = :enrollment, file)
    # Goal 1: Build an array of these... {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}
    # all_enrollment_data = []
    # CSV.foreach do |row|
    #   For each row
    #   Check if the name is already present
    #   If name is not present
    #     Add a new hash with a key of name that points to the location
    #   Always Add the year as a key under the kindergarten_participation hash with a value of enrollment rate as a percentage
    #  Goal 2: After the array of hashes is complete we need to iterate over the array and return an array of Enrollment objects



    files = file[data_kind]
    tagged_files = {}
    files.each_pair do |data_kind, file|
      opened_file = CSV.open file,
      headers: true, header_converters: :symbol
      tagged_files[data_kind] = opened_file
    end
    tagged_files
  end
end

# binding.pry
# ""
