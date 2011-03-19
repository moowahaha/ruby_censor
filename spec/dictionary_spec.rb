require 'fileutils'
require 'tmpdir'

describe Censor::Dictionary do

  describe "sections" do

    it "should only be included when specified" do
      dictionary = Censor::Dictionary.new(fixture_dictionary, [:expletives])
      dictionary.has_similar?('moron').should be_false
      dictionary.has_similar?('hamster').should be_true
    end

  end

  describe "matching" do

    before do
      @dictionary = Censor::Dictionary.new(fixture_dictionary, [:expletives, :racism])
    end

    it "should tell me when it contains a particular word" do
      @dictionary.has_similar?('moron').should be_true
    end

    it "should tell me when it does not contain a particular word" do
      @dictionary.has_similar?('something else').should be_false
    end

    it "should be case insensitive" do
      @dictionary.has_similar?('MORON').should be_true
    end

    it "should detect similar (but not exact) words" do
      @dictionary.has_similar?('hamstre').should be_true
    end

    it "should not match false positives" do
      @dictionary.has_similar?('doddle').should be_false
    end

    it "should not match 2 letter words" do
      @dictionary.has_similar?('is').should be_false
    end

  end

  describe "training" do

    it "should ..." do
      tmp_dictionary = File.join(Dir.tmpdir, File.basename(fixture_dictionary))
      FileUtils.copy(fixture_dictionary, tmp_dictionary)

      Censor::Dictionary.new(tmp_dictionary, [:racism]).has_similar?('mormon').should be_true

      Censor::Dictionary.rebuild(
          :safe_word_files => safe_word_files,
          :censurable_dictionary_file => tmp_dictionary
      )

      Censor::Dictionary.new(tmp_dictionary, [:racism]).has_similar?('mormon').should be_false

      FileUtils.rm(tmp_dictionary)
    end

  end

end