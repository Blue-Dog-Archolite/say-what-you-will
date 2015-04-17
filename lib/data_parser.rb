class DataParser
  attr_accessor :source_file, :hashed_data

  def initialize(source_file = 'data/shakespeare-complete.txt')
    @source_file = source_file
    @hashed_data = {}
  end

  def completion_data
    @indexed ||= create_index
  end

  private

  def file_as_array
    # Parse and strip non-letter chars
    @stripped_file ||=  open source_file do |file|
      file.read.index_sanitize
    end
  end

  def create_index
    group_by_with_count.each do |word, count|
      next if word.empty?
      hashed_key = ''

      word.each_char do |char|
        hashed_key = hashed_key + "['#{char}']"
        create_values(hashed_key, word, count)
      end

      instance_eval("hashed_data#{hashed_key}['value'] = #{count}")
    end

    hashed_data
  end

  def create_values(hashed_key, word, count)
    # Set base level hash values if not existing
    instance_eval("hashed_data#{hashed_key} ||= {'words' => []}")

    # Sets words at this level of complete
    instance_eval("hashed_data#{hashed_key}['words'] << {'word' => '#{word}', 'count' => #{count} }")
  end

  def group_by_with_count
    # This is group by with count
    # This helps performance a bit for iterations due to only having
    # to do the index once per word
    @grouped_data ||= file_as_array.each_with_object(Hash.new(0)) {|e, h| h[e] += 1}
  end
end
