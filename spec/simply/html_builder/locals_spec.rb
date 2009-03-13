require File.dirname(__FILE__) + "/../../spec_helper"

module Simply
  describe HtmlBuilder, "with locals" do
    before(:each) do
      @builder = HtmlBuilder.new
    end
    
    it "should have access to a variables value" do
      @builder.locals = { :foo => "bar" }
      @builder.ul do
        li foo
      end

      @builder.to_s.should == "<ul><li>bar</li></ul>"
    end

    it "should convert integer keys to strings" do
      @builder.locals = { :foo => 1 }
      @builder.ul do
        li foo
      end

      @builder.to_s.should == "<ul><li>1</li></ul>"
    end

    it "should be able to use any number of keys" do
      @builder.locals = { :foo => 1, :bar => 2, :baz => 3}
      @builder.ul do
        li foo
        li bar
        li baz
      end

      @builder.to_s.should == "<ul><li>1</li><li>2</li><li>3</li></ul>"
    end

    it "should take locals in the constructor" do
      builder = HtmlBuilder.new(:locals => { :foo => "bar", :bar => "baz" }) do
        ul do
          li foo
          li bar
        end
      end

      builder.to_s.should == "<ul><li>bar</li><li>baz</li></ul>"
    end
  end
end