require 'crypt/rot13'

class Censor
  VERSION = '0.0.1'

  def self.add words, options = {:adjective => false, :plural => false, :past_tense => false, :rot13 => false}
    @@censored_words ||= []

    [words].flatten.each do |word|
      safe_word = Regexp.escape(
          options[:rot13] ? Crypt::Rot13.new(word.downcase).to_s : word.downcase
      )

      @@censored_words << past_tense_for(safe_word)
      @@censored_words << singular_for(safe_word)
      @@censored_words << adjective_for(safe_word) if options[:adjective]
      @@censored_words << plural_for(safe_word) if options[:plural]
    end

    @@censored_words.uniq!
    @@censored_words.flatten!
    @@censored_words.sort! { |a, b| b.first.length <=> a.first.length }
  end

  def initialize options = {:hint => false, :replace_with => '*'}
    @replace_with_method = options[:hint] ? 'with_hint' : 'blankout'
    @replacement_character = options[:replace_with] || '*'
  end

  def replace text
    clean_text = text.dup

    (@@censored_words | []).each do |censored|
      clean_text.gsub!(censored[:regexp], send(@replace_with_method, censored[:word]))
    end

    clean_text
  end

  private

  def with_hint word
    word_chars = word.split('')
    first_char, last_char = word_chars.shift, word_chars.pop
    first_char + (@replacement_character * word_chars.length) + last_char
  end

  def blankout word
    @replacement_character * word.length
  end

  class << self

    def past_tense_for word
      [
          {:word => word + 'ed', :regexp => regexp_for(word + 'ed')},
          {:word => word + 'd', :regexp => regexp_for(word + 'd')}
      ]
    end

    def singular_for word
      {:word => word, :regexp => regexp_for(word)}
    end

    def adjective_for word
      adjectival_matchers = [
          {:word => word + 'ing', :regexp => regexp_for(word + 'ing')},
          {:word => word + 'in', :regexp => regexp_for(word + 'in')}
      ]

      adjectival_matchers |= (adjective_for(word + 't')) if word !~ /(!?t)t$/ && word =~ /t$/

      adjectival_matchers
    end

    def plural_for word
      {:word => word + "s", :regexp => regexp_for(word + "s")}
    end

    def regexp_for word
      Regexp.new(/\b#{word}\b/i)
    end

  end

end

Dir.glob(File.join(File.dirname(__FILE__), %w{censored_words ** *.rb})).each do |file|
  require file
end

#http://www.asa.org.uk/Resource-Centre/~/media/Files/ASA/Reports/ASA_Delete_Expletives_Dec_2000.ashx