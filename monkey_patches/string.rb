# Thanks for this idea Wikipedia
# http://rosettacode.org/wiki/Inverted_index#Ruby

class String

  # Let's give the string class the ability to tokenize itself into lowercase
  # words with no punctuation.
  def index_sanitize
    self.split.collect do |token|
      token.downcase.gsub(/\W/, '')
    end
  end
end
