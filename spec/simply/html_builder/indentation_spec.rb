require File.dirname(__FILE__) + "/../../spec_helper"

module Simply
  describe HtmlBuilder, "with indentation" do
    before(:each) do
      @builder = HtmlBuilder.new(:indent => true)
    end
    
    it "should be indented when passed :indent => true" do
      builder = HtmlBuilder.new(:indent => true)
      builder.should be_indented
    end
    
    it "should not be indented when passed :indent => false" do
      builder = HtmlBuilder.new(:indent => false)
      builder.should_not be_indented
    end
    
    it "should not be indented by default" do
      builder = HtmlBuilder.new
      builder.should_not be_indented
    end
    
    it "should indent html when indented = true, and given a block structure" do
      @builder.html do
        body do
        end
      end
      
      @builder.to_s.should == (<<-HERE).chomp
<html>
  <body>
  </body>
</html>
HERE
    end
    
    it "should not indent tags which are on the same block level" do
      @builder.br
      @builder.br
      @builder.to_s.should == "<br />\n<br />"
    end
  end
end
