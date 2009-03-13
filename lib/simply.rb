module Simply
  dir = File.dirname(__FILE__) + "/simply"

  require "rubygems"
  require "builder/xchar"
  require "#{dir}/indentation"
  require "#{dir}/html_tags"
  require "#{dir}/html_builder"
end

def Simply(options={}, &block)
  builder = Simply::HtmlBuilder.new(options, &block)
  builder.to_s
end
