module Mutant
  class Mutator
    class Generator
      def initialize(node,block)
        @sexp,@block = node.to_sexp,block
      end

      def append(node)
        p same_node?(node)
        unless same_node?(node)
          @block.call(node)
        end
      end

      # FIXME: Use interhitable alias once in support gem.
      alias :<< :append

    private

      def same_node?(node)
        @sexp == node.to_sexp
      end
    end
  end
end