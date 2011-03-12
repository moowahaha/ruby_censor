require 'rcensor/cli'
require 'stringio'

describe Rcensor::CLI, "execute" do
  before(:each) do
    @stdout_io = StringIO.new
    Rcensor::CLI.execute(@stdout_io, [])
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
  
  it "should print default output" do
    @stdout.should =~ /To update this executable/
  end
end
