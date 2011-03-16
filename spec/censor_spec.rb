describe Censor do

  class Test < Censor

    Censor.add 'leap', :adjective => true, :plural => true

  end

  it "should replace my word with a custom character" do
    Censor.new(:replace_with => '_').replace('i leap').should == 'i ____'
  end

  describe 'replacing' do

    before do
      @censor = Test.new
    end

    it "should replace a dodgy word" do
      @censor.replace('leap').should == '****'
    end

    it "should censor plurals when appropriate" do
      @censor.replace('leaps').should == '*****'
    end

    it "should replace adjectives when appropriate" do
      @censor.replace('leaping').should == '*******'
    end

  end

  describe 'hinting' do

    before do
      @censor = Test.new(:hint => true)
    end

    it "should replace a dodgy word" do
      @censor.replace('leap').should == 'l**p'
    end

    it "should replace a plural" do
      @censor.replace('leaps').should == 'l***s'
    end

    it "should replace an adjective" do
      @censor.replace('leaping').should == 'l*****g'
    end

  end

end