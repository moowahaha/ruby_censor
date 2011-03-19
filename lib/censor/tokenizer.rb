class Censor
  class Tokenizer
    def self.for text
      text.split(/\s+/).each do |word|
        yield word
      end.join(' ')
    end
  end
end