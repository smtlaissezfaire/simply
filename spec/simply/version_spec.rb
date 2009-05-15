require File.dirname(__FILE__) + "/../spec_helper"

describe Simply, "'s Version" do
  it "should be at 0.1.2" do
    Simply::VERSION.should == "0.1.2"
  end
end