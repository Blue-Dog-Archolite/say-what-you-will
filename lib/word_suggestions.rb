module WordSuggestion

  def self.suggest_words(partial, completion_data)
    word_key = ''
    possible_solutions = nil

    # I know there is an inject way to do this...
    partial.each_char do |c|
      word_key += "['#{c}']"
    end

    instance_eval("possible_solutions = completion_data#{word_key}")

    unless possible_solutions['words']
      puts "No Suggestions found for #{partial}."
    else
      top_25 = possible_solutions['words'].sort_by { |hsh| hsh['count'] }.reverse.slice(0..25)

      # Sort and take the top 25
      puts "The top #{top_25.length} suggestions for #{partial} are:"
      top_25.each_with_index do |suggestion, index|
        puts "#{index+1}: #{suggestion['word']} used #{suggestion['count']}"
      end

    end

  rescue => e
    puts '%'*20
    puts possible_solutions['words'].sort_by { |hsh| hsh['count'] }
    puts '%'*20
  end
end
