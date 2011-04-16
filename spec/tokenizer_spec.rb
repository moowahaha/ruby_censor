describe Censor::Tokenizer do

  it "should replace words in a string" do
    Censor::Tokenizer.for('a b c') do |char|
      'X'
    end.should == 'X X X'
  end

  it "should preserve word breaks words in a string" do
    Censor::Tokenizer.for("a-b\nc") do |char|
      'X'
    end.should == "X-X\nX"
  end

end