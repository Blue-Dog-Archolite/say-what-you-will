Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/monkey_patches/*.rb'].each {|file| require file }

puts DataParser.new.group_by_with_count

# Just implementing a simple inverted index here.
#ARGV.each do |filename|
#  open filename do |file|
#    file.read.index_sanitize.each do |word|
#      @data[word] ||= []
#      @data[word] << filename unless @data[word].include? filename
#    end
#  end
#end
