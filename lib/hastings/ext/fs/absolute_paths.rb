module Hastings
  module FS
    # {AbsolutePaths} forces absolute paths to be used instead of relative paths
    # when instantiating StringIO objects. It is included in {Hastings::File}
    # and {Hastings::Dir}
    module AbsolutePaths
      # Proxy for StringIO based objects to use absolute paths instead of
      # relative paths so that they still work if we change directories
      # @param args [Array] the first argument is assumed to be a path
      # @return the object with an absolute path
      def initialize(*args)
        args.first.replace(File.absolute_path args.first)
        super(*args)
      end
    end
  end
end
