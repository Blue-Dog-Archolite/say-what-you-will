class DataStore
  attr_reader :data_dump

  def initialize(data_dump = 'data/data_storage.dat')
    @data_dump = data_dump
  end

  def load_from_source
    return unless File.exist? data_dump

    Marshal.load open( data_dump )
  end

  def data
    @data ||= load_from_source
  end

  def persist(data)
    md = Marshal.dump(data)

    open(data_dump, "w") do |index|
      index.write md
    end
  end
end
