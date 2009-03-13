module Simply
  dir = File.dirname(__FILE__) + "/simply"

  require "rubygems"
  require "builder/xchar"
  require "#{dir}/html_tags"
  require "#{dir}/html_builder"
  require "#{dir}/indentation"
end

def Simply(&block)
  s = Simply::HtmlBuilder.new(&block)
  s.to_s
end
