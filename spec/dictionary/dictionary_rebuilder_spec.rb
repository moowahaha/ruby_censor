require 'fileutils'
require 'tmpdir'

describe Censor::Dictionary::Rebuilder do

  it "rebuild the false positive list from accidentally censored safe words" do
    tmp_dictionary = File.join(Dir.tmpdir, File.basename(fixture_dictionary))
    FileUtils.copy(fixture_dictionary, tmp_dictionary)

    Censor::Dictionary.new(tmp_dictionary, [:racism]).has_similar?('mormon').should be_true

    Censor::Dictionary::Rebuilder.rebuild(
        :safe_word_files => safe_word_files,
        :censurable_dictionary_file => tmp_dictionary
    )

    Censor::Dictionary.new(tmp_dictionary, [:racism]).has_similar?('mormon').should be_false

    FileUtils.rm(tmp_dictionary)
  end

end