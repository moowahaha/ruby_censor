require File.join(File.dirname(__FILE__), %w{.. censor})

class Censor
  class Racism < Censor

    include CensoredWords::Racism

  end
end