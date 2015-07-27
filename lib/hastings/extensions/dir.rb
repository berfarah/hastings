module Hastings
  # Additional directory operations
  class Dir < ::Dir
    def initialize(path)
      super File.absolute_path(path)
    end

    def files(glob = "*", **args)
      return glob_files(glob) if args.empty?
      args.inject(glob_files(glob)) do |a, (method, value)|
        a.select { |f| f.public_send("#{method}?", value) }
      end
    end

    def dirs(glob = "*")
      glob_dirs(glob)
    end

    private

      def glob_files(str)
        glob(str).select(&File.method(:file?)).map(&File.method(:new))
      end

      def glob_dirs(str)
        glob(str).select(&File.method(:directory?)).map(&Dir.method(:new))
      end

      # We use the absolute path of the files to ensure our glob is useful
      def glob(str)
        Dir.chdir(path) { self.class.glob(str).map { |f| File.join path, f } }
      end
  end
end
