module CensoredWords
  module Expletives

    Censor.add %w{fuck shit bloody}, :adjectives => true, :plural => true, :past_tense => true

  end
end