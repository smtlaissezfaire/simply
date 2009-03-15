module Simply
  module Escaping
    #
    # A utility method for escaping HTML tag characters in _s_.
    # 
    #  Taken from ERB::Util
    # 	
    # 	puts html_escape("is a > 0 & a < 10?")
    # 
    # _Generates_
    # 
    # 	is a &gt; 0 &amp; a &lt; 10?
    #
    def html_escape(s)
      s.to_s.gsub(/&/, "&amp;").gsub(/\"/, "&quot;").gsub(/>/, "&gt;").gsub(/</, "&lt;")
    end
    
    alias_method :h, :html_escape
  end
end
