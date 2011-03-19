require File.join(File.dirname(__FILE__), 'censor', 'dictionary')
require File.join(File.dirname(__FILE__), 'censor', 'tokenizer')

class Censor
  VERSION = '0.0.1'

  def initialize settings
    @dictionary = Censor::Dictionary.new(dictionary_file, settings[:censored_words])
  end

  def clean string
    Censor::Tokenizer.for(string) do |word|
      @dictionary.has_similar?(word) ? '*' * word.length : word
    end
  end

  private

  def dictionary_file
    ENV['CENSOR_DICTIONARY'] ?
        ENV['CENSOR_DICTIONARY'] :
        File.join(File.dirname(__FILE__), %w{.. dictionary censurable_words.yml})
  end
end

#http://www.asa.org.uk/Resource-Centre/~/media/Files/ASA/Reports/ASA_Delete_Expletives_Dec_2000.ashx