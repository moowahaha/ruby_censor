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

    describe "plurals" do

      it "should be replaced when appropriate" do
        @censor.replace('leaps').should == '*****'
      end

      it "(possessive) should be replaced when appropriate" do
        @censor.replace("leap's").should == "****'s"
      end

    end

    describe "adjectives" do

      it "should be replaced when appropriate" do
        @censor.replace('leaping').should == '*******'
      end

      it "(lazy) should be replaced when appropriate" do
        @censor.replace('leapin').should == '******'
      end

    end

  end

  describe 'hinting' do

    before do
      @censor = Test.new(:hint => true)
    end

    it "should replace a dodgy word" do
      @censor.replace('leap').should == 'l**p'
    end

    describe "plurals" do

      it "should be replaced when appropriate" do
        @censor.replace('leaps').should == 'l***s'
      end

      it "(possessive) should be replaced when appropriate" do
        @censor.replace("leap's").should == "l**p's"
      end

    end

    it "should replace an adjective" do
      @censor.replace('leaping').should == 'l*****g'
    end

  end

end