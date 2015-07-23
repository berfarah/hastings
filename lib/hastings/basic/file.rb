module Hastings
  module Basic
    # Additional operations
    class File < ::File
      # We only deal with absolute paths for easy reference
      def initialize(path, *args)
        super(File.absolute_path(path), *args)
      end

      def basename
        File.basename(path)
      end

      def newer_than(date)
        ctime > parse_time(date)
      end

      def older_than(date)
        ctime < parse_time(date)
      end

      def on_day(date)
        ctime.to_date == day(date)
      end

      private

        def day(date_time)
          Date.parse(date_time)
        end

        def parse_time(date_time)
          Time.parse(date_time)
        end
    end
  end
end
