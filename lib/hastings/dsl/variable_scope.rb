module Hastings
  # Each task gets its own variable scope stored in this object
  class VariableScope
    def initialize
      @variables = {}
    end

    def self.method_missing(sym, argument)
      str = sym.to_s
      if /=$/ =~ str
        @variables[no_equals(str)] = argument
      else @variables[sym]
      end
    end

    private

      def no_equals(str)
        str[0..-2].to_sym
      end
  end
end
