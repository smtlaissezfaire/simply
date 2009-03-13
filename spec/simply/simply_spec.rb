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
  
  it "should pass locals in" do
    s = Simply :locals => {:foo => "foo"} do
      text foo
    end
    
    s.should == "foo"
  end
  
  it "should pass indentation in" do
    s = Simply :indent => true do
      html do
        body do
          p "foo"
        end
      end
    end
    
    s.should == (<<-HERE).chomp
<html>
  <body>
    <p>
      foo
    </p>
  </body>
</html>
HERE
  end
end
