module Hastings
  module Basic
    # Our model of a loop
    class Loop
      def initialize(list, &block)
        @list     = list
        @block    = block
        @enum     = enum
      end

      # Our own enumerable interface
      def each
        @list.each(&@block)
      end

      private

        # We don't need to handle conversion for anything that has an each
        # method. This includes:
        #   Hash, Array, StringIO
        def enum
          @list.respond_to?(:each) ? @list : make_enum
        end

        # Convert non-enumerable objects to enumerables with some assumptions
        def make_enum
          case @list
          # Assume our strings will be either comma or newline separated
          when String then @list.gsub("\n", ",").split ","
          # Assume our user wants a range when passing in numbers
          when Fixnum then 1..@list
          else fail NotImplementedError
          end
        end
    end
  end
end
