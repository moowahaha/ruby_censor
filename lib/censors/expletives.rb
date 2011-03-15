class Censor
  class Expletives < Censor
    def censored_words
      %w{fuck shit bloody}
    end
  end
end