require 'amatch'
require 'yaml'

class Censor
  class Dictionary
    include Amatch

    MAXIMUM_WORD_DISTANCE = 4
    MINIMUM_WORD_LENGTH = 3

    def initialize censurable_file, sections
      @censurable_file = censurable_file
      build_word_lists(censurable_file, sections)
    end

    def has_similar? word
      return false if word.length < MINIMUM_WORD_LENGTH

      dc_word = word.downcase

      # exact match (yay)
      return true if @censurable_list[dc_word]
      return false if @false_positives[dc_word]

      # approximate match
      @censurable_list.values.each do |matcher|
        return true if matcher.match(dc_word) <= MAXIMUM_WORD_DISTANCE
      end

      false
    end

    class << self

      def rebuild settings
        censurable_file = settings[:censurable_dictionary_file]
        contents = YAML.load_file(censurable_file)

        safe_words = build_safe_word_list(settings)
        update_censurable_file_contents(censurable_file, contents, safe_words)
        write_censurable_file(censurable_file, contents)
      end

      private

      def write_censurable_file(censurable_file, contents)
        File.open(censurable_file, 'w') do |fh|
          fh.write contents.to_yaml
        end
      end

      def update_censurable_file_contents(censurable_file, contents, safe_words)
        dictionary = new(censurable_file, contents['bad_words'].keys)

        false_positives = []

        safe_words.uniq.each do |word|
          next if safe_words.length < MINIMUM_WORD_LENGTH
          false_positives << word if dictionary.has_similar?(word)
        end

        contents['false_positives'] |= false_positives
        contents['false_positives'].sort!.uniq!
      end

      def build_safe_word_list(settings)
        safe_words = []

        settings[:safe_word_files].each do |file|
          safe_words |= File.open(file).read.split("\n")
        end
        safe_words
      end

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