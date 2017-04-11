require 'csv'

module LoadData
  #Load data into the program to be accessed from other places
  #use what I learned from the event manager to do this
  #
  def says_hi
    "Hello"
  end

  def load_data(data_kind = :enrollment, file)
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
