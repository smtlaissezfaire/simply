module Simply
  dir = File.dirname(__FILE__) + "/simply"
  
  require "#{dir}/version"
  include Version
  
  require "rubygems"
  require "builder/xchar"
  require "#{dir}/locals"
  require "#{dir}/indentation"
  require "#{dir}/html_tags"
  require "#{dir}/html_builder"
end

def Simply(options={}, &block)
  builder = Simply::HTMLBuilder.new(options, &block)
  builder.to_s
end
