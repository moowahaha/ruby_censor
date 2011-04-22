describe Censor::Dictionary do

  describe "sections" do

    before do
      @dictionary = Censor::Dictionary.new(fixture_dictionary, [:expletives])
    end

    it "should only be included when specified" do
      @dictionary.has_similar?('moron').should be_false
      @dictionary.has_similar?('hamster').should be_true
    end

    it "should provide a list of the words we're censoring" do
      @dictionary.censored_words['doodle'].should be_true
    end

    it "should provide a list of the words we consider safe" do
      @dictionary.safe_words['doddle'].should be_true
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

    it "should not match when the first character is different" do
      @dictionary.has_similar?('noron').should be_false
    end

  end

end