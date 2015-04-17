Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/monkey_patches/*.rb'].each {|file| require file }

data_store = DataStore.new
completion_data = nil

if data_store.data
  puts 'Lodaing from File'
  completion_data = data_store.data
else
  puts 'Parsing from file'
  completion_data = DataParser.new.completion_data
  data_store.persist(grouped_data)
end

puts completion_data


# Just implementing a simple inverted index here.
#ARGV.each do |filename|
#  open filename do |file|
#    file.read.index_sanitize.each do |word|
#      @data[word] ||= []
#      @data[word] << filename unless @data[word].include? filename
#    end
#  end
#end
