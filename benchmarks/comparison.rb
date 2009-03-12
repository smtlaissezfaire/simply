#!/usr/bin/env ruby
require 'benchmark'
require "erb"
require 'rubygems'
require 'markaby'
require 'tagz'
require 'builder'
require 'haml'
require 'erubis'
require "nokogiri"
require "erector"
require File.dirname(__FILE__) + "/../lib/simply"

MAX = (ARGV.shift || 10_000).to_i

def do_nothing
  # do nothing
end

def do_erb
  str = <<-EOF
<html>
  <head>
    <title>happy title</title>
  </head>
  <body>
    <h1>happy heading</h1>
    <a href='<%= 'url' %>'>a link</a>
  </body>
</html>
EOF
  ERB.new(str)
end

def do_erubis
  str = <<-EOF
<html>
  <head>
    <title>happy title</title>
  </head>
  <body>
    <h1>happy heading</h1>
    <a href='<%= 'url' %>'>a link</a>
  </body>
</html>
EOF
  Erubis::Eruby.new(str)
end

def do_haml
  str = <<-EOF
%html
  %head
    %title_ "happy title"
  %body
    %h1 "happy heading"
    %a "a link", :href => "url"
EOF
  Haml::Engine.new(str)
end

def do_tagz
  Tagz {
    html_ {
      head_ {
        title_ "happy title"
      }
      body_ {
        h1_ "happy heading"
        a_ "a link", :href => "url"
      }
    }
  }
end

def do_builder
  Builder::XmlMarkup.new.html do |xm|
    xm.head do
      xm.title "happy title"
    end
    xm.body do
      xm.h1 "happy heading"
      xm.a "a link", :href => "url"
    end
  end
end

def do_markaby
  mab = Markaby::Builder.new :output_meta_tag => false

  mab.html {
    head {
      title "happy title"
    }
    body {
      h1 "happy heading"
      a "a link", :href => "url"
    }
  }.to_s
end

def do_simply
  Simply do
    html do
      head do
        title "happy title"
      end

      body do
        h1 "happy heading"
        a "a link", :href => "url"
      end
    end
  end
end

def do_nokogiri
  Nokogiri do
    html do
      head do
        title "happy title"
      end

      body do
        h1 "happy heading"
        a :href => "url" do
          text "a link"
        end
      end
    end
  end
end

def do_erector
  Erector::Widget.new do
    html do
      head do
        title "happy title"
      end

      body do
        h1 "happy heading"
        a "a link", :href => "url"
      end
    end
  end
end


x = do_tagz
y = do_markaby
z = do_builder

raise "bad!\n\n#{x}\n\n#{y}" unless x == y
raise "bad!\n\n#{x}\n\n#{z}" unless x == z

puts "# of iterations = #{MAX}"
Benchmark.bmbm do |x|
  x.report("counter time") do
    for i in 0..MAX
      # do nothing
    end
  end

  x.report("counter time + function call overhead time") do
    for i in 0..MAX do
      do_nothing
    end
  end

  x.report("tagz") do
    for i in 0..MAX do
      do_tagz
    end
  end

  x.report("markaby") do
    for i in 0..MAX do
      do_markaby
    end
  end

  x.report("builder") do
    for i in 0..MAX do
      do_builder
    end
  end

  x.report("haml") do
    for i in 0..MAX do
      do_haml
    end
  end

  x.report("erb") do
    for i in 0..MAX do
      do_erb
    end
  end

  x.report("erubis") do
    for i in 0..MAX do
      do_erubis
    end
  end

  x.report("nokogiri") do
    for i in 0..MAX do
      do_nokogiri
    end
  end

  x.report("simply") do
    for i in 0..MAX do
      do_simply
    end
  end

  x.report("erector") do
    for i in 0..MAX do
      do_erector
    end
  end
end
