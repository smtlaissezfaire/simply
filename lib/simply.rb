
module Simply
  class HtmlBuilder
    SELF_CLOSING_TAGS = [ :base, :meta, :link, :hr, :br, :param, :img, :area, :input, :col, :frame ]

    def initialize(&block)
      @out = ""
      instance_eval(&block) if block_given?
    end

    def p(text=nil, &block)
      if block_given?
        tag(:p, &block)
      else
        tag(:p, text)
      end
    end

    SELF_CLOSING_TAGS.each do |tag|
      define_method(tag) do
        self_closing_tag(tag)
      end
    end

    ####################
    #
    #  Utilities
    #
    ####################

    def text(out)
      @out << out
    end

    def to_s
      @out
    end

  private

    def tag(tag_name, value=nil, &block)
      text opening_tag(tag_name)
      value ? text(value) : instance_eval(&block)
      text closing_tag(tag_name)
    end

    def opening_tag(tag_name)
      "<#{tag_name}>"
    end

    def closing_tag(tag_name)
      "</#{tag_name}>"
    end

    def self_closing_tag(tag_name)
      @out << "<#{tag_name} />"
    end
  end
end

def Simply(&block)
  s = Simply::HtmlBuilder.new(&block)
  s.to_s
end
