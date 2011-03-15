describe Censor::MyName do

  %w{bloody fuck shit}.each do |word|

    it "should censor the '#{word}'" do
      censor = Censor::Expletives.new
      censor.replace("blah blah '#{word}' de blah").should == "blah blah '#{'*' * word.length}' de blah"
    end

  end

end
