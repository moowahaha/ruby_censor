require 'amatch'
require 'yaml'

class Censor
  class Dictionary
    include Amatch

    attr_reader :censored_words, :safe_words

    MAXIMUM_WORD_DISTANCE = 3
    MINIMUM_WORD_LENGTH = 3

    def initialize censurable_file, sections
      build_word_lists(censurable_file, sections)
    end

    def has_similar? word
      return false if word.length < MINIMUM_WORD_LENGTH

      dc_word = word.downcase

      # exact match (yay)
      return true if @censored_words[dc_word]

      # fp match
      return false if @safe_words[dc_word]

      # slower approximate match
      @censored_words.each do |word, matcher|
        next false if word[0..1] != dc_word[0..1]
        is_censored = matcher.match(dc_word) <= MAXIMUM_WORD_DISTANCE
        is_censored ? @censored_words[dc_word] : @safe_words
        return true if is_censored
      end

      false
    end

    def self.available censurable_file
      YAML.load_file(censurable_file)['bad_words'].keys.sort.map {|w| w.to_sym}
    end

    private

    def build_censored_word_list(contents, sections)
      @censored_words = {}

      sections.each do |section|
        contents['bad_words'][section.to_s].each do |word|
          next if word.length < MINIMUM_WORD_LENGTH
          @censored_words[word.downcase] = Hamming.new(word)
        end
      end
    end

    def build_safe_word_list(contents)
      @safe_words = {}

      (contents['false_positives'] || []).each do |word|
        @safe_words[word.downcase] = true
      end
    end

    def build_word_lists(censurable_file, sections)
      contents = YAML.load_file(censurable_file)
      build_censored_word_list(contents, sections)
      build_safe_word_list(contents)
    end

  end
end