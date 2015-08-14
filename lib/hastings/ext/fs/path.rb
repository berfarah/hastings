require "pathname"

module Hastings
  module FS
    # {Path} provides some basic path operations to StringIO classes. It is
    # included in {Hastings::File} and {Hastings::Dir}
    module Path
      # @return [Pathname] a frozen pathname object based on the absolute path
      #   of the parent object
      def pathname
        @pathname ||= Pathname.new(path).freeze
      end

      # @return [String] a frozen string of the basename of the object
      def basename
        @basename ||= pathname.basename.to_s.freeze
      end

      # @return [String] a frozen string of the dirname of the object
      def dirname
        @dirname ||= pathname.dirname.to_s.freeze
      end

      # Lets us expand the path based on the object's class
      #
      # @param args [Array[String]]
      # @return [String] of the path with the arguments `File#join` ed on
      def join(*args)
        pathname.join(*args).to_s
      end
    end
  end
end
