require File.join(File.dirname(__FILE__), %w{.. censor})

class Censor
  class Expletives < Censor
    
    include CensoredWords::Expletives
    include CensoredWords::AdjectivalExpletives

  end
end