describe Censor do
  it "should clean up the Offspring song Bad Habbit" do
    dirty = %q{
You stupid dumbshit goddam motherfucker
I open the glove box
Reach inside
I'm gonna wreck this fucker's ride
    }

    clean = %q{
You stupid ******** goddam ************
I open the glove box
Reach inside
I'm gonna wreck this ******'s ride
    }

    Censor.new(:censored_words => [:expletives]).clean(dirty).should == clean
  end
end