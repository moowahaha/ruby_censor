namespace :censor do
  desc "Update the false positive list"
  task :fp_clean do
    Censor::Dictionary::Rebuilder.rebuild(
        :safe_word_files => ['/usr/share/dict/words'],
        :censurable_dictionary_file => File.join(
            File.dirname(__FILE__),
            '..', 'dictionary', 'censurable_words.yml'
        )
    )
  end
end