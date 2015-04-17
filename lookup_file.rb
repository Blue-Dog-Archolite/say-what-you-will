Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/monkey_patches/*.rb'].each {|file| require file }

data_store = DataStore.new
completion_data = nil

if data_store.data
  puts 'Loading from File'
  completion_data = data_store.data
else
  puts 'Parsing from file'
  puts 'This will take a while'
  completion_data = DataParser.new.completion_data
  data_store.persist(completion_data)
end


# Take anything passed in on the command line in any form and break it
# down the same way we did when making the index.
ARGV.join(' ').index_sanitize.each do |word|
  WordSuggestion.suggest_words(word, completion_data)
end
