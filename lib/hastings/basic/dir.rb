module Hastings
  module Basic
    # Additional directory operations
    class Dir < ::Dir
      def files(glob = "*", **args)
        return _files(glob) if args.empty?
        args.inject(_files(glob)) do |a, (method, value)|
          a.select { |f| f.public_send(method, value) }
        end
      end

      private

        def _files(glob)
          Dir.chdir(path) do
            self.class.glob(glob || "*").map { |f| File.new(f) }
          end
        end
    end
  end
end
