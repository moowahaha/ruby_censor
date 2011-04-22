describe Censor do

  it "should get the dictionary" do
    Censor::Dictionary.should_receive(:new).with(/.*\/\.\.\/dictionary\/censurable_words\.yml/, [:expletives])
    Censor.new(:censored_words => [:expletives])
  end

  it "should get the dictionary from a custom location when asked" do
    with_fixture_dictionary do
      Censor::Dictionary.should_receive(:new).with(fixture_dictionary, [:expletives])
      Censor.new(:censored_words => [:expletives])
    end
  end

  it "should tokenize a string" do
    with_fixture_dictionary do
      string = 'yodel ey hee hoo'
      Censor::Tokenizer.should_receive(:for).with(string).and_return('bob')
      Censor.new(:censored_words => [:expletives]).clean(string).should == 'bob'
    end
  end

  it "should censor expletives" do
    Censor.new(:censored_words => [:expletives]).clean('fuck this SHIT!').should == '**** this ****!'
  end

  it "should give a hint to the rude word" do
    Censor.new(
        :censored_words => [:expletives],
        :hint => true
    ).clean("fuck this SHIT's me!").should == "f**k this S**T's me!"
  end

end