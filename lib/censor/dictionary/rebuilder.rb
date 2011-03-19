require File.join(File.dirname(__FILE__), '..', 'dictionary')

class Censor
  class Dictionary
    class Rebuilder

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
          dictionary = Censor::Dictionary.new(censurable_file, contents['bad_words'].keys)

          false_positives = []

          safe_words.uniq.each do |word|
            next if safe_words.length < MINIMUM_WORD_LENGTH
            next if dictionary.censored_words.include?(word)
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

    end
  end
end

