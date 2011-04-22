require File.join(File.dirname(__FILE__), 'censor', 'dictionary')
require File.join(File.dirname(__FILE__), 'censor', 'tokenizer')

class Censor
  VERSION = '0.0.1'

  def initialize settings
    @dictionary = Censor::Dictionary.new(self.class.dictionary_file, settings[:censored_words])
    @replacement_method = settings[:hint] ? :hint : :redact
  end

  def clean string
    Censor::Tokenizer.for(string) do |word|
      @dictionary.has_similar?(word) ? send(@replacement_method, word) : word
    end
  end

  def self.available_dictionaries
    Censor::Dictionary.available(dictionary_file)
  end

  private

  def self.dictionary_file
    ENV['CENSOR_DICTIONARY'] ?
        ENV['CENSOR_DICTIONARY'] :
        File.join(File.dirname(__FILE__), %w{.. dictionary censurable_words.yml})
  end

  def hint word
    chars = word.split('')
    first_char, last_char = chars.shift, chars.pop
    first_char + redact(chars.join('')) + last_char
  end

  def redact word
    '*' * word.length
  end
end
