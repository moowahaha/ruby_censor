describe Censor::MyName do
  
  it "should censor my surname" do
    censor = Censor::MyName.new
    censor.replace("steve hardisty's 10 minute censor").should == "steve ********'s 10 minute censor"
  end

end
