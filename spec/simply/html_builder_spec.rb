require File.dirname(__FILE__) + "/../spec_helper"

module Simply
  describe HTMLBuilder do
    before(:each) do
      @builder = HTMLBuilder.new
    end

    it "should create a self-closing hr tag" do
      @builder.br
      @builder.to_s.should == "<br />"
    end

    it "should create a self closing hr tag" do
      @builder.hr
      @builder.to_s.should == "<hr />"
    end

    it "should create two self-closing tags" do
      @builder.br
      @builder.hr
      @builder.to_s.should == "<br /><hr />"
    end

    it "should output text directly with the text method" do
      @builder.text "foo"
      @builder.to_s.should == "foo"
    end
    
    it "should call to_s on the object given to text" do
      obj = Object.new
      obj.stub!(:to_s).and_return "foo"
      @builder.text obj
      @builder.to_s.should == "foo"
    end

    it "should have a paragraph tag" do
      @builder.p "foo"
      @builder.to_s.should == "<p>foo</p>"
    end

    it "should contain the text inside the paragraph tags" do
      @builder.p "bar baz"
      @builder.to_s.should == "<p>bar baz</p>"
    end

    it "should take options with a string given" do
      @builder.p "bar baz", :class => :something

      @builder.to_s.should == "<p class=\"something\">bar baz</p>"
    end

    it "should have a paragraph tag which takes a block" do
      @builder.p do
        text "foo"
      end

      @builder.to_s.should == "<p>foo</p>"
    end

    Simply::HTMLBuilder::SELF_CLOSING_TAGS.each do |tag|
      it "should have the tag #{tag}" do
        @builder.send(tag)
        @builder.to_s.should == "<#{tag} />"
      end
    end

    it "should set options given to a self-closing tag" do
      @builder.img :src => "foo"
      @builder.to_s.should == "<img src=\"foo\" />"
    end

    it "should set two options to a self-closing tag" do
      @builder.img :src => "foo", :alt => :some_text
      out = @builder.to_s
      out.should =~ /<img.*alt=\"some_text\".*\/>/
      out.should =~ /<img.*src=\"foo\".*\/>/
    end

    it "should set options on a non-self closing tag (like a p)" do
      @builder.p :class => :foo, :name => :something do
        text "foo"
      end

      @builder.to_s.should == '<p class="foo" name="something">foo</p>'
    end
    
    Simply::HTMLBuilder::BLOCK_TAGS.each do |tag|
      it "should have the #{tag} tag" do
        @builder.send(tag, "foo")
        @builder.to_s.should == "<#{tag}>foo</#{tag}>"
      end

      it "should contain the text inside the #{tag} tags" do
        @builder.send(tag, "bar baz")
        @builder.to_s.should == "<#{tag}>bar baz</#{tag}>"
      end
      
      it "should take options with a string given" do
        @builder.send(tag, "bar baz", :class => :something)
      
        @builder.to_s.should == "<#{tag} class=\"something\">bar baz</#{tag}>"
      end
      
      it "should have a paragraph tag which takes a block" do
        @builder.send(tag) do
          text "foo"
        end
      
        @builder.to_s.should == "<#{tag}>foo</#{tag}>"
      end
    end

    it "should raise an argument error when calling a closing tag with no options" do
      lambda {
        @builder.p
      }.should raise_error(ArgumentError)
    end

    it "should escape special html values" do
      @builder.h1 'Apples & Oranges'
      @builder.to_s.should == "<h1>Apples &amp; Oranges</h1>"
    end

    it "should be able to generate the xhtml-transitional dtd declaration" do
      @builder.xhtml_transitional
      @builder.to_s.should include('<?xml version="1.0" encoding="UTF-8"?>')
      @builder.to_s.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">')
    end

    it "should be able to generate the xhtml strict declaration" do
      @builder.xhtml_strict
      @builder.to_s.should include('<?xml version="1.0" encoding="UTF-8"?>')
      @builder.to_s.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">')
    end

    it "should be able to generate the xhtml frameset" do
      @builder.xhtml_frameset
      @builder.to_s.should include('<?xml version="1.0" encoding="UTF-8"?>')
      @builder.to_s.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">')
    end
    
    it "should be able to build an empty node" do
      @builder.text "Add Text"
      @builder.to_s.should == "Add Text"
    end
  end
end
