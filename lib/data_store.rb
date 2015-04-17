class DataStore
  attr_reader :file_name
  def initialize(file_name = 'data/data_storage.dat')
    @file_name = file_name
  end

  def load_from_source
    return {} unless File.exist? file_name

    Marshal.load open( file_name )
  end

  def data
    @data ||= load_from_source
  end

  def persist
    open(file_name, "w") do |index|
      index.write Marshal.dump(@data)
    end
  end
end
