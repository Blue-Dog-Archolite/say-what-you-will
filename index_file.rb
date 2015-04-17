Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/monkey_patches/*.rb'].each {|file| require file }

data_store = DataStore.new
grouped_data = nil

grouped_data = if data_store.data
                  puts 'Lodaing from File'
                  grouped_data = data_store.data
                else
                  puts 'Parsing from file'
                  data = DataParser.new.group_by_with_count
                  data_store.persist(data)
                  data
                end

puts grouped_data


# Just implementing a simple inverted index here.
#ARGV.each do |filename|
#  open filename do |file|
#    file.read.index_sanitize.each do |word|
#      @data[word] ||= []
#      @data[word] << filename unless @data[word].include? filename
#    end
#  end
#end
