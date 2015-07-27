require "hastings/dsl/variable_scope"

module Hastings
  # DSL proxy
  class Dsl
    attr_reader :var

    def initialize(&block)
      @var = VariableScope.new
      instance_eval(&block)
    end
  end
end
