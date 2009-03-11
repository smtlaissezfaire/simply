
module Simply
  class HtmlBuilder
    SELF_CLOSING_TAGS = [ :base, :meta, :link, :hr, :br, :param, :img, :area, :input, :col, :frame ]

    def initialize(&block)
      @out = ""
      instance_eval(&block) if block_given?
    end

    def p(options={ }, &block)
      tag(:p, options, &block)
    end

    SELF_CLOSING_TAGS.each do |tag|
      class_eval <<-HERE
        def #{tag}(options={})
          self_closing_tag(:#{tag}, options)
        end
      HERE
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

    def tag(tag_name, options={ }, &block)
      text opening_tag(tag_name, options)
      instance_eval(&block)
      text closing_tag(tag_name)
    end

    def opening_tag(tag_name, options={ })
      if options.any?
        "<#{tag_name} #{expand_options(options)}>"
      else
        "<#{tag_name}>"
      end
    end

    def closing_tag(tag_name)
      "</#{tag_name}>"
    end

    def self_closing_tag(tag_name, options={ })
      if options.any?
        text "<#{tag_name} #{expand_options(options)} />"
      else
        text "<#{tag_name} />"
      end
    end

    def expand_options(options)
      options.map { |key, value| "#{key}=\"#{value}\""}.join(" ")
    end
  end
end

def Simply(&block)
  s = Simply::HtmlBuilder.new(&block)
  s.to_s
end
