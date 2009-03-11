require File.dirname(__FILE__) + "/../spec_helper"

module Simply
  describe HtmlBuilder do
    before(:each) do
      @builder = HtmlBuilder.new
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

    it "should have a paragraph tag" do
      pending "TODO: Make these part of an object which derives/overrides Simply methods" do
        @builder.p "foo"
        @builder.to_s.should == "<p>foo</p>"
      end
    end

    it "should contain the text inside the paragraph tags" do
      pending "TODO: Make these part of an object which derives/overrides Simply methods" do
        @builder.p "bar baz"
        @builder.to_s.should == "<p>bar baz</p>"
      end
    end

    it "should have a paragraph tag which takes a block" do
      @builder.p do
        text "foo"
      end

      @builder.to_s.should == "<p>foo</p>"
    end

    SELF_CLOSING_TAGS = [ :base, :meta, :link, :hr, :br, :param, :img, :area, :input, :col, :frame ]

    SELF_CLOSING_TAGS.each do |tag|
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
      @builder.to_s.should == "<img alt=\"some_text\" src=\"foo\" />"
    end

    it "should set options on a non-self closing tag (like a p)" do
      @builder.p :class => :foo, :name => :something do
        text "foo"
      end

      @builder.to_s.should == '<p class="foo" name="something">foo</p>'
    end
  end
end

  
#   def test_classes_and_ids
#     assert_equal %{<div class="one"></div>}, mab { div.one '' }
#     assert_equal %{<div class="one two"></div>}, mab { div.one.two '' }
#     assert_equal %{<div id="three"></div>}, mab { div.three! '' }
#     assert_equal %{<hr class="hidden"/>}, mab { hr.hidden }
#     assert_equal %{<input class="foo" name="bar" id="bar"/>}, mab { input.foo :id => 'bar' }
#   end
  
#   def test_escaping
#     assert_equal "<h1>Apples &amp; Oranges</h1>", mab { h1 'Apples & Oranges' }
#     assert_equal "<h1>Apples & Oranges</h1>", mab { h1 { 'Apples & Oranges' } }
#     assert_equal "<h1 class=\"fruits&amp;floots\">Apples</h1>", mab { h1 'Apples', :class => 'fruits&floots' }
#   end

#   def test_capture
#     builder = Markaby::Builder.new
#     assert builder.to_s.empty?
#     assert_equal "<h1>TEST</h1>", builder.capture { h1 'TEST' }
#     assert builder.to_s.empty?
#     assert mab { capture { h1 'hello world' }; nil }.empty?
#     assert_equal mab { div { h1 'TEST' } }, mab { div { capture { h1 'TEST' } } }
#   end

#   def test_ivars
#     html = "<div><h1>Steve</h1><div><h2>Gerald</h2></div><h3>Gerald</h3></div>"
#     assert_equal html, mab { div { @name = 'Steve'; h1 @name; div { @name = 'Gerald'; h2 @name }; h3 @name } }
#     assert_equal html, mab { div { @name = 'Steve'; h1 @name; self << capture { div { @name = 'Gerald'; h2 @name } }; h3 @name } }
#     assert_equal html, mab(:name => 'Steve') { div { h1 @name; self << capture { div { @name = 'Gerald'; h2 @name } }; h3 @name } }
#   end

#   def test_ivars_without_at_symbol 
#     assert_equal "<h1>Hello World</h1>", mab { @message = 'Hello World'; h1 message } 
#   end 
  
#   def test_helpers
#     Markaby::Builder.ignored_helpers.clear
#     assert_equal %{squirrels}, mab({}, MarkabyTestHelpers) { pluralize('squirrel') }
#     assert_equal %{<a href="">edit</a>}, mab({}, MarkabyTestHelpers) { link_to('edit') }
#     assert mab({}, MarkabyTestHelpers) { @output_helpers = false; link_to('edit'); nil }.empty?
#     Markaby::Builder.ignore_helpers :pluralize
#     assert_exception(NoMethodError, "no such method `pluralize'", {}, MarkabyTestHelpers) { pluralize('squirrel') }
#   end

#   def test_builder_bang_methods
#     assert_equal "<?xml version=\"1.0\" encoding=\"UTF-8\"?>", mab { instruct! }
#   end

#   def test_fragments
#     assert_equal %{<div><h1>Monkeys</h1><h2>Giraffes <small>Miniature</small> and <strong>Large</strong></h2><h3>Donkeys</h3><h4>Parakeet <b><i>Innocent IV</i></b> in Classic Chartreuse</h4></div>}, 
#         mab { div { h1 "Monkeys"; h2 { "Giraffes #{small 'Miniature' } and #{strong 'Large'}" }; h3 "Donkeys"; h4 { "Parakeet #{b { i 'Innocent IV' }} in Classic Chartreuse" } } }
#     assert_equal %{<div><h1>Monkeys</h1><h2>Giraffes <strong>Miniature</strong></h2><h3>Donkeys</h3></div>}, 
#         mab { div { h1 "Monkeys"; h2 { "Giraffes #{strong 'Miniature' }" }; h3 "Donkeys" } }
#     assert_equal %{<div><h1>Monkeys</h1><h2>Giraffes <small>Miniature</small> and <strong>Large</strong></h2><h3>Donkeys</h3><h4>Parakeet <strong>Large</strong> as well...</h4></div>}, 
#         mab { div { @a = small 'Miniature'; @b = strong 'Large'; h1 "Monkeys"; h2 { "Giraffes #{@a} and #{@b}" }; h3 "Donkeys"; h4 { "Parakeet #{@b} as well..." } } }
#   end

#   def test_invalid_xhtml
#     assert_exception(NoMethodError, "no such method `dav'") { dav {} }
#     assert_exception(Markaby::InvalidXhtmlError, "no attribute `styl' on div elements") { div(:styl => 'ok') {} }
#     assert_exception(Markaby::InvalidXhtmlError, "no attribute `class' on tbody elements") { tbody.okay {} }
#   end

#   def test_full_doc_transitional
#     doc = mab { xhtml_transitional { head { title 'OKay' } } }    
#     assert doc =~ /^<\?xml version="1.0" encoding="UTF-8"\?>/
#     assert doc.include?(%{"-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">})
#     assert doc.include?(%{<title>OKay</title>})
#   end

#   def test_full_doc_strict
#     doc = mab { xhtml_strict { head { title 'OKay' } } }
#     assert doc =~ /^<\?xml version="1.0" encoding="UTF-8"\?>/
#     assert doc.include?(%{"-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">})
#     assert doc.include?(%{<title>OKay</title>})
#   end
  
#   def test_full_doc_frameset
#     doc = mab { xhtml_frameset { head { title 'OKay' } } }
#     assert doc =~ /^<\?xml version="1.0" encoding="UTF-8"\?>/
#     assert doc.include?(%{"-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">})
#     assert doc.include?(%{<title>OKay</title>})
#   end

#   def test_root_attributes_can_be_changed
#     doc = mab { xhtml_strict(:lang => 'fr') { head { title { 'Salut!' } } } }
#     assert doc.include?(%{"-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">})
#     assert doc.include?(%{<title>Salut!</title>})
#     assert doc.include?(%{ lang="fr"})
#   end

# end

