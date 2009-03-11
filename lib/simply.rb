
module Simply
  class HtmlBuilder
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

    def br
      self_closing_tag :br
    end

    def hr
      self_closing_tag :hr
    end

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
