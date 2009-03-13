require File.dirname(__FILE__) + "/../spec_helper"

module Simply
  describe Indentation do
    before(:each) do
      @stream = ""
      @stream.extend Indentation
    end
    
    it "should be able to add text to the buffer" do
      @stream << "foo"
      @stream.should == "foo"
    end
    
    it "should indent by two after a call to indent" do
      @stream.indent
      @stream << "foo"
      @stream.should == "  foo"
    end
    
    it "should indent multiple calls, each on new lines" do
      @stream.indent
      @stream << "foo"
      @stream << "bar"
      @stream.should == "  foo\n  bar"
    end
    
    it "should indent by 4, when passed 4 explicitly" do
      @stream.indent(4)
      @stream << "foo"
      @stream.should == "    foo"
    end
    
    it "should nest indentation" do
      @stream << "foo do"
      @stream.indent
      @stream <<   "something do"
      @stream.indent
      @stream <<     "bar do"
      
      @stream.should == "foo do\n  something do\n    bar do"
    end
    
    it "should outdent" do
      @stream.indent
      @stream.outdent
      @stream << "foo"
      @stream.should == "foo"
    end
    
    it "should outdent by the number of spaces given" do
      @stream.indent(2)
      @stream.indent(2)
      @stream.outdent(4)
      @stream << "foo"
      @stream.should == "foo"
    end
    
    it "should raise an error if outdenting too far" do
      @stream.indent(2)
      lambda {
        @stream.outdent(4)
      }.should raise_error(Indentation::IndentationError, "You can't outdent before the beginning of the page")
    end
    
    it "should raise an indentation error if the page hasn't yet been indented" do
      lambda {
        @stream.outdent
      }.should raise_error(Indentation::IndentationError)
    end
  end
end