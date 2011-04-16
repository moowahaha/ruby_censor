class Censor
  class Tokenizer
    def self.for text
      text.split(/(\W+)/).map do |word|
        if word =~ /\W+/
          word
        else
          yield word
        end
      end.join($1)
    end
  end
end