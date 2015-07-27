module Hastings
  module Dsl
    # Simplified file operations
    module FileOperations
      def file(path)
        File.new(path)
      end

      def copy_file(from:, to:)
        file(from).copy_to to
      end

      def move_file(from:, to:)
        file(from).move_to to
      end

      def directory(path)
        Dir.new(path)
      end
    end
  end
end
