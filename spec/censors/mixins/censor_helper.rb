def it_should_include mixin
  it "should include the mixin #{mixin}" do
    described_class.should include(mixin)
  end
end

def it_should_censor_words_such_as word
  it "should censor the word '#{word}'" do
    described_class.new.replace("blah blah #{word} blah").should == "blah blah #{'*' * word.length} blah"
  end
end