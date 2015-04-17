class DataParser
  attr_accessor :source_file

  def initialize(source_file = 'data/shakespeare-complete.txt')
    @source_file = source_file
  end

  def file_as_array
    # Parse and strip non-letter chars
    @stripped_file ||=  open source_file do |file|
                          file.read.index_sanitize
                        end
  end

  def group_by_with_count
    # This is group by with count
    file_as_array.each_with_object(Hash.new(0)) {|e, h| h[e] += 1}
  end


end
