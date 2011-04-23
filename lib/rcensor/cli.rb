require 'trollop'

module Rcensor
  class CLI
    def self.execute(stdout, arguments=[])
      opts = Trollop::options do
        opt :hint, "Leave a hint to the original word", :default => false
        opt :text, "Text to censor", :type => :string
      end

      puts Censor.new(
               :censored_words => Censor.available_dictionaries,
               :hint => opts[:hint]
           ).clean(opts[:text])
    end
  end
end