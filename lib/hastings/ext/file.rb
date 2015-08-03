require "fileutils"

module Hastings
  # Hastings file with extensions
  class File < ::File
    # Additional operations
    module Core
      def basename
        File.basename(path)
      end

      alias_method :to_s, :basename

      def copy_to(dir, overwrite: true)
        return false if !overwrite && to_path_exist?(dir)
        FileUtils.cp(path, dir_path(dir))
      end

      def move_to(dir, overwrite: true)
        return false if !overwrite && to_path_exist?(dir)
        FileUtils.mv(path, dir_path(dir))
      end

      private

        def dir_path(destination)
          destination.is_a?(String) ? destination : destination.path
        end

        def to_path_exist?(dir)
          to = dir_path(dir)
          File.file?(to) ||
            Dir.exist?(to) && File.file?(File.join to, basename)
        end
    end

    # Methods related to the file's timestamps
    module Time
      def self.included(base)
        base.extend(ClassMethods)
      end

      # used_time method to be added
      module ClassMethods
        def used_time(method_symbol)
          alias_method :used_time, method_symbol
        end
      end

      def used_time
        fail NotImplementedError, "Assign the type of time to be used by "\
        "calling used_time :method_symbol in #{self.class.name} "\
        "(eg: used_time :ctime)"
      end

      def newer_than?(time)
        used_time > time
      end

      def older_than?(time)
        used_time < time
      end

      def created_on?(date)
        ctime.to_date == date
      end

      def created_between?(date_range)
        date_range.include? ctime.to_date
      end
    end

    include Core
    include Time

    # We only deal with absolute paths for easy reference
    def initialize(path, *args)
      super(File.absolute_path(path), *args)
    end

    used_time :ctime
  end
end
