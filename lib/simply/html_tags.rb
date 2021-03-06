module Simply
  module HTMLTags
    unless defined?(XML_ENCODING)
      XML_ENCODING = '<?xml version="1.0" encoding="UTF-8"?>'.freeze

      STRICT       = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'.freeze
      TRANSITIONAL = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.freeze
      FRAMESET     = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">'.freeze

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
  end
end
