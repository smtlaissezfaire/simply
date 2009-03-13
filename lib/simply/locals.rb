module Simply
  module Locals
    # Pass in a hash of local variables
    # which will be available to the template:
    #
    #    @builder.locals = { :foo => 1, :bar => 2, :baz => 3}
    #    @builder.ul do
    #      li foo
    #      li bar
    #      li baz
    #    end
    #
    #    @builder.to_s #=> "<ul><li>1</li><li>2</li><li>3</li></ul>"
    def locals=(hash={ })
      def metaclass(&block)
        meta = class << self; self; end
        meta.instance_eval(&block)
      end

      hash.each do |key, value|
        metaclass do
          define_method key do
            value
          end
        end
      end
    end
  end
end