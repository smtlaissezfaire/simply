module Simply
  dir = File.dirname(__FILE__) + "/simply"
  
  require "#{dir}/html_tags"
  require "#{dir}/html_builder"
end

def Simply(&block)
  s = Simply::HtmlBuilder.new(&block)
  s.to_s
end
