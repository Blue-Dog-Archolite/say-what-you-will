Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/monkey_patches/*.rb'].each {|file| require file }

data_store = DataStore.new
completion_data = nil

if data_store.data
  puts 'Loading from File'
  completion_data = data_store.data
else
  puts 'Parsing from file'
  puts 'This will take a while....'
  completion_data = DataParser.new.completion_data
  data_store.persist(completion_data)
end

# This is a testing value that will parse and display the hash that is generated.
# Not suggested for regular usage
puts completion_data
