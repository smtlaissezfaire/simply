module Simply
  class HtmlBuilder
    SELF_CLOSING_TAGS = HTMLTags::SELF_CLOSING_TAGS
    BLOCK_TAGS        = HTMLTags::BLOCK_TAGS
    
    def initialize(&block)
      @out = ""
      instance_eval(&block) if block_given?
    end

    SELF_CLOSING_TAGS.each do |tag|
      class_eval <<-HERE, __FILE__, __LINE__
        def #{tag}(attributes={})
          __self_closing_tag(:#{tag}, attributes)
        end
      HERE
    end
    
    BLOCK_TAGS.each do |tag|
      class_eval <<-HERE, __FILE__, __LINE__
        def #{tag}(*args, &block)
          if args.first.is_a?(String)
            block = lambda { clean_text args.first }
            options = args[1] || { }
          else
            options = args.first || { }
          end

          __tag(:#{tag}, options, &block)
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

    def clean_text(out)
      text html_escape(out)
    end

    def html_escape(out)
      out.to_s.to_xs
    end

    def to_s
      @out
    end

  private

    def __tag(tag_name, attributes={ }, &block)
      text __opening_tag(tag_name, attributes)
      instance_eval(&block)
      text __closing_tag(tag_name)
    end

    def __opening_tag(tag_name, attributes={ })
      if attributes.any?
        "<#{tag_name} #{__expand_attributes(attributes)}>"
      else
        "<#{tag_name}>"
      end
    end

    def __closing_tag(tag_name)
      "</#{tag_name}>"
    end

    def __self_closing_tag(tag_name, attributes={ })
      if attributes.any?
        text "<#{tag_name} #{__expand_attributes(attributes)} />"
      else
        text "<#{tag_name} />"
      end
    end

    def __expand_attributes(attributes)
      attributes.map { |key, value| "#{key}=\"#{value}\""}.join(" ")
    end
  end
end
