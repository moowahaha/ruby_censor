require File.join(File.dirname(__FILE__), %w{.. censor})

class Censor
  class MyName < Censor
    Censor.add 'hardisty'
  end
end