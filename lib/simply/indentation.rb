module Simply
  module Indentation
    class IndentationError < StandardError
      def message
        "You can't outdent before the beginning of the page"
      end
    end
    
    DEFAULT_NUM_SPACES_TO_INDENT = 2
    DEFAULT_INDENTATION_LEVEL    = 0
    
    def <<(text)
      super("#{" " * indentation_level}#{text}\n")
    end
    
    def indent(number_of_spaces = DEFAULT_NUM_SPACES_TO_INDENT)
      @indentation_level ||= DEFAULT_INDENTATION_LEVEL
      @indentation_level += number_of_spaces
    end
    
    def outdent(number_of_spaces = DEFAULT_NUM_SPACES_TO_INDENT)
      @indentation_level ||= DEFAULT_INDENTATION_LEVEL
      @indentation_level -= number_of_spaces
      raise IndentationError if @indentation_level < 0
      @indentation_level
    end
    
    def indentation_level
      @indentation_level ||= DEFAULT_INDENTATION_LEVEL
    end
  end
end