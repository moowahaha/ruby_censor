require 'amatch'
require 'yaml'

class Censor
  class Dictionary
    include Amatch

    MAXIMUM_WORD_DISTANCE = 4
    MINIMUM_WORD_LENGTH = 3

    def initialize censurable_file, sections
      build_word_lists(censurable_file, sections)
    end

    def censored_words
      @censurable_list.keys
    end

    def has_similar? word
      return false if word.length < MINIMUM_WORD_LENGTH

      dc_word = word.downcase

      # exact match (yay)
      return true if @censurable_list[dc_word]

      # fp match
      return false if @false_positives[dc_word]

      # slower approximate match
      @censurable_list.values.each do |matcher|
        return true if matcher.match(dc_word) <= MAXIMUM_WORD_DISTANCE
      end

      false
    end

    private

    def build_censurable_word_list(contents, sections)
      @censurable_list = {}

      sections.each do |section|
        contents['bad_words'][section.to_s].each do |word|
          next if word.length < MINIMUM_WORD_LENGTH
          @censurable_list[word.downcase] = Hamming.new(word)
        end
      end
    end

    def build_false_positive_list(contents)
      @false_positives = {}

      (contents['false_positives'] || []).each do |word|
        @false_positives[word.downcase] = true
      end
    end

    def build_word_lists(censurable_file, sections)
      contents = YAML.load_file(censurable_file)
      build_censurable_word_list(contents, sections)
      build_false_positive_list(contents)
    end

  end
end