require "fileutils"

module Hastings
  # Additional operations
  class File < ::File
    # We only deal with absolute paths for easy reference
    def initialize(path, *args)
      super(File.absolute_path(path), *args)
    end

    def basename
      File.basename(path)
    end

    alias_method :to_s, :basename

    def copy_to(to_path, overwrite: true)
      return false if !overwrite && copy_to_exist?(basename, to_path)
      FileUtils.cp(path, to_path)
    end

    def newer_than?(time)
      ctime > time
    end

    def older_than?(time)
      ctime < time
    end

    def created_on?(date)
      ctime.to_date == date
    end

    def created_between?(date_range)
      date_range.include? ctime.to_date
    end

    private

      def copy_to_exist?(from, to)
        File.file?(to) ||
          Dir.exist?(to) && File.file?(File.join to, from)
      end
  end
end
