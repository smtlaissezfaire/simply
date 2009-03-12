module Simply
  module HTMLTags
    SELF_CLOSING_TAGS = [ 
      :base,
      :meta,
      :link,
      :hr,
      :br,
      :param,
      :img,
      :area,
      :input,
      :col,
      :frame
    ]
    
    BLOCK_TAGS = [
      :html,
      :head,
      :title,
      :style,
      :script,
      :noscript,
      :body,
      :div,
      :p,
      :ul,
      :ol,
      :li,
      :dl,
      :dt,
      :dd,
      :address,
      :pre,
      :blockquote,
      :ins,
      :del,
      :a,
      :span,
      :bdo,
      :em,
      :strong,
      :dfn,
      :code,
      :samp,
      :kbd,
      :var,
      :cite,
      :abbr,
      :acronym,
      :q,
      :sub,
      :sup,
      :tt,
      :i,
      :b,
      :big,
      :small,
      :object,
      :map,
      :form,
      :label,
      :select,
      :optgroup,
      :option,
      :textarea,
      :fieldset,
      :legend,
      :button,
      :table,
      :caption,
      :colgroup,
      :thead,
      :tfoot,
      :tbody,
      :tr,
      :th,
      :td,
      :h1,
      :h2,
      :h3,
      :h4,
      :h5,
      :h6,
      :strike,
      :center,
      :dir,
      :noframes,
      :basefont,
      :u,
      :menu,
      :iframe,
      :font,
      :s,
      :applet,
      :isindex,
      :script,
      :a,
      :td,
      :h5,
      :h3,
      :li,
      :div,
      :pre,
      :body,
      :ol,
      :h4,
      :h2,
      :object,
      :legend,
      :dl,
      :h6,
      :ul,
      :form,
      :h1
    ]
  end
  
  class HtmlBuilder
    SELF_CLOSING_TAGS = HTMLTags::SELF_CLOSING_TAGS
    BLOCK_TAGS        = HTMLTags::BLOCK_TAGS
    
    def initialize(&block)
      @out = ""
      instance_eval(&block) if block_given?
    end

    SELF_CLOSING_TAGS.each do |tag|
      class_eval <<-HERE
        def #{tag}(attributes={})
          self_closing_tag(:#{tag}, attributes)
        end
      HERE
    end
    
    BLOCK_TAGS.each do |tag|
      class_eval <<-HERE
        def #{tag}(*args, &block)
          if args.first.is_a?(String)
            block = lambda { text args.first }
            options = args[1] || { }
          else
            options = args.first || { }
          end

          tag(:#{tag}, options, &block)
        end
      
      HERE
    end
    
    def p(*args, &block)
      if args.first.is_a?(String)
        block = lambda { text args.first }
        options = args[1] || { }
      else
        options = args.first || { }
      end
      
      tag(:p, options, &block)
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

    def tag(tag_name, attributes={ }, &block)
      text opening_tag(tag_name, attributes)
      instance_eval(&block)
      text closing_tag(tag_name)
    end

    def opening_tag(tag_name, attributes={ })
      if attributes.any?
        "<#{tag_name} #{expand_attributes(attributes)}>"
      else
        "<#{tag_name}>"
      end
    end

    def closing_tag(tag_name)
      "</#{tag_name}>"
    end

    def self_closing_tag(tag_name, attributes={ })
      if attributes.any?
        text "<#{tag_name} #{expand_attributes(attributes)} />"
      else
        text "<#{tag_name} />"
      end
    end

    def expand_attributes(attributes)
      attributes.map { |key, value| "#{key}=\"#{value}\""}.join(" ")
    end
  end
end

def Simply(&block)
  s = Simply::HtmlBuilder.new(&block)
  s.to_s
end
