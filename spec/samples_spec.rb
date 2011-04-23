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

  it "should clean up Mr Parker form Way of the Gun" do
    Censor.new(
        :censored_words => [:expletives],
        :hint => true
    ).clean(
        "Shut that cunt's mouth or I'll come over there and fuckstart her head"
    ).should == "Shut that c**t's mouth or I'll come over there and f*******t her head"
  end

  it "should clean up Richard Prior" do
    Censor.new(
        :censored_words => [:expletives, :genitalia, :sexism],
        :hint => true
    ).clean(
        "Bitch was so fine I'd suck her daddy's dick."
    ).should == "B***h was so fine I'd suck her daddy's d**k."
  end

  it "should stop Joey LaMotta from Raging Bull saying 'dick'" do
    Censor.new(
        :censored_words => [:genitalia]
    ).clean(
      "Your mother sucks big fuckin' elephant dicks, you got that?"
    ).should == "Your mother sucks big fuckin' elephant *****, you got that?"
  end

  it "should censor Niggaz 4 Life" do
    dirty = %q{
      Why do I call myself a nigger, you ask me?
      I guess it's the way shit has to be
      Back when I was young gettin a job was murder
      Fuck flippin burgers
    }

    clean = %q{
      Why do I call myself a n****r, you ask me?
      I guess it's the way s**t has to be
      Back when I was young gettin a job was murder
      F**k flippin burgers
    }

    Censor.new(
        :censored_words => [:expletives, :racism],
        :hint => true
    ).clean(dirty).should == clean
  end

  it "should preserve some perfectly clean passage of text" do
    text = File.open(File.join(File.dirname(__FILE__), 'fixtures', 'clean.txt')).read
    Censor.new(:censored_words => Censor.available_dictionaries).clean(text).should == text
  end
end