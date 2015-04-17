class DataParser
  attr_reader :source_file

  def initialize(source_file = 'data/shakespeare-complete.txt')
    @source_file = source_file
  end

  def file_as_array
    # Parse and strip non-letter chars
    @stripped_file ||=  open source_file do |file|
                          file.read.index_sanitize
                        end
  end

  def create_index
    hashed = {}
    hashed_key = ''
    to_eval = ''

    group_by_with_count.each do |word, count|
      next if word.empty?
      hashed_key = ''

      word.each_char do |char|
        hashed_key = hashed_key + "['#{char}']"
        instance_eval("hashed#{hashed_key} ||= {}")
      end

      to_eval = "hashed#{hashed_key}['vaue'] = #{count}"
     instance_eval(to_eval)
    end

    hashed
  end

  def completion_data
    @indexed ||= create_index
  end

  def group_by_with_count
    # This is group by with count
    # This helps performance a bit for iterations due to only having
    # to do the index once per word
    @grouped_data ||= file_as_array.each_with_object(Hash.new(0)) {|e, h| h[e] += 1}
  end
end
