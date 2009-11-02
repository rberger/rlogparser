require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rlogparser/cli'

describe Rlogparser::CLI, "execute" do
  before(:each) do
    @stdout_io = StringIO.new
    Rlogparser::CLI.execute(@stdout_io, [])
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
  
  it "should print default output" do
    @stdout.should =~ /Parses a rails logfile from the Runa Runtime/
  end
end