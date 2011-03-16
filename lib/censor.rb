class Censor
  VERSION = '0.0.1'

  def self.add words, options = {:adjective => false, :plural => false}
    @@censored_words ||= []

    [words].flatten.each do |word|
      @@censored_words << singular_for(word)
      @@censored_words << adjective_for(word) if options[:adjective]
      @@censored_words << plural_for(word) if options[:plural]
    end

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

    def singular_for word
      {:word => word, :regexp => regexp_for(word)}
    end

    def adjective_for word
      [
          {:word => word + 'ing', :regexp => regexp_for(word + 'ing')},
          {:word => word + 'in', :regexp => regexp_for(word + 'in')}
      ]
    end

    def plural_for word
      {:word => word + "'s", :regexp => regexp_for(word + "'s")}
      {:word => word + 's', :regexp => regexp_for(word + 's')}
    end

    def regexp_for word
      Regexp.new(/\b#{Regexp.escape(word)}\b/, Regexp::IGNORECASE)
    end

  end

end

Dir.glob(File.join(File.dirname(__FILE__), %w{censored_words ** *.rb})).each do |file|
  require file
end

#http://www.asa.org.uk/Resource-Centre/~/media/Files/ASA/Reports/ASA_Delete_Expletives_Dec_2000.ashx