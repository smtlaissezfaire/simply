require File.dirname(__FILE__) + "/../lib/simply"

TIMES = 1000

TIMES.times do
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
