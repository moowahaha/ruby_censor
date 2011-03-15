class Censor
  VERSION = '0.0.1'

  def self.add words
    @@censored_words ||= []
    @@censored_words << words
    @@censored_words.flatten!
    @@censored_words.sort! {|a, b| b.length <=> a.length}
  end

  def replace text
    clean_text = text.dup

    (@@censored_words | []).each do |word|
      clean_text.gsub!(/\b#{word}\b/i, '*' * word.length)
    end

    clean_text
  end
end

Dir.glob(File.join(File.dirname(__FILE__), %w{censored_words ** *.rb})).each do |file|
  require file
end

#http://www.asa.org.uk/Resource-Centre/~/media/Files/ASA/Reports/ASA_Delete_Expletives_Dec_2000.ashx