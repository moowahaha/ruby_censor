module CensoredWords
  module Racism

    Censor.add %w{avttre}, :adjectives => true, :plural => true, :rot13 => true

  end
end