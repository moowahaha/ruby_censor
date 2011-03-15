require File.join(File.dirname(__FILE__), %w{.. censor})

class Censor
  class Expletives < Censor
    
    include CensoredWords::Expletives

  end
end