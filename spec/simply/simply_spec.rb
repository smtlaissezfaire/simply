require File.dirname(__FILE__) + "/../spec_helper"

describe Simply, "the method" do
  it "should take a block" do
    Simply do
      
    end
  end

  it "should produce html with the block" do
    s = Simply do
      br
    end

    s.should == "<br />"
  end
end
