describe Censor do

  it "should get the dictionary" do
    Censor::Dictionary.should_receive(:new).with(/.*\/\.\.\/dictionary\/censurable_words\.yml/, [:expletives])
    Censor.new(:censored_words => [:expletives])
  end

  it "should get the dictionary from a custom location when asked" do
    ENV['CENSOR_DICTIONARY'] = fixture_dictionary
    Censor::Dictionary.should_receive(:new).with(fixture_dictionary, [:expletives])
    Censor.new(:censored_words => [:expletives])
    ENV.delete('CENSOR_DICTIONARY')
  end

  it "should censor expletives" do
    Censor.new(:censored_words => [:expletives]).clean('fuck this SHIT!').should == '**** this ****!'
  end

end