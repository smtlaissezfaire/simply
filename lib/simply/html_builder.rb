module Simply
  class HTMLBuilder
    include Locals
    include Escaping
    
    unless defined?(SELF_CLOSING_TAGS)
      SELF_CLOSING_TAGS = HTMLTags::SELF_CLOSING_TAGS
      BLOCK_TAGS        = HTMLTags::BLOCK_TAGS
    end
    
    def initialize(options={ }, &block)
      @out = ""

      if locals_hash = options[:locals]
        self.locals = locals_hash
      end
      
      @indented = options[:indented].equal?(false) ? false : true
      @out.extend Indentation if indented?
      
      instance_eval(&block) if block_given?
    end
    
    def indented?
      @indented ? true : false
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
          raise ArgumentError if !block_given? && args.empty?

          if block_given? || args.first.is_a?(Hash)
            options = args.first || { }
          else
            block = lambda { clean_text args.first.to_s }
            options = args[1] || { }
          end

          __tag(:#{tag}, options, &block)
        end
      HERE
    end

    def xhtml_transitional
      text HTMLTags::XML_ENCODING
      text HTMLTags::TRANSITIONAL
    end

    def xhtml_strict
      text HTMLTags::XML_ENCODING
      text HTMLTags::STRICT
    end

    def xhtml_frameset
      text HTMLTags::XML_ENCODING
      text HTMLTags::FRAMESET
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

    def to_s
      @out
    end

  private

    def __tag(tag_name, attributes={ }, &block)
      text __opening_tag(tag_name, attributes)
      __eval_block(&block)
      text __closing_tag(tag_name)
    end
    
    def __eval_block(&block)
      @out.indent if indented?
      instance_eval(&block)
      @out.outdent if indented?
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
