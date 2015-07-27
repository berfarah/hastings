require "hastings/dsl"

module Hastings
  # Assign things
  class Script
    attr_reader :meta

    def initialize(&block)
      @meta = Meta.new
      @meta.instance_eval(&block)
    end

    def run
      Dsl.new(&@meta.run)
    end

    # Script meta
    class Meta
      attr_reader :meta
      ALLOWED_METHODS = %i(name description run_every run_at run).freeze

      def initialize
        @meta = {}
      end

      def run_at(date_time = nil)
        return meta[:run_at] if meta[:run_at]
        meta[:run_at] = DateTime.parse(date_time)
      end

      def method_missing(name, *args, &block)
        return super unless ALLOWED_METHODS.include? name
        return meta[name] if meta[name]
        meta[name] = block_given? ? block : args.first.freeze
      end
    end
  end
end
