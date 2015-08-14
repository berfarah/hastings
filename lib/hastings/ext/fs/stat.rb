module Hastings
  module FS
    # {Stat} provides methods related to the time a file was created, accessed or
    # modified. It is included in {Hastings::File} and {Hastings::Dir}
    module Stat

      # @!group Accessed methods

      # @return [Time] the time the object was last accessed
      def accessed
        atime
      end

      # @param date [Date] the date on which the object is meant
      #   to have been last accessed
      # @return [Boolean] whether or not the object was last accessed
      #   on that date
      def accessed_on?(date)
        accessed.to_date == date
      end

      # @param date_range [Hastings::DateRange] a range of dates during which
      #   the object is meant to have been last accessed
      # @return [Boolean] whether or not the object was last accessed
      #   on that date
      def accessed_between?(date_range)
        date_range.include? accessed.to_date
      end

      # @!endgroup
      # @!group Created methods

      # @return [Time] the time the object was create
      def created
        ctime
      end

      # @param date [Date] the date on which the object is meant
      #   to have been created
      # @return [Boolean] whether or not the object was created
      #   on that date
      def created_on?(date)
        created.to_date == date
      end

      # @param date_range [Hastings::DateRange] a range of dates during which the
      #   object is meant to have been created
      # @return [Boolean] whether or not the object was created
      #   on that date
      def created_between?(date_range)
        date_range.include? created.to_date
      end

      # @param time [Time] a time that the object is meant to have been
      #   created after
      # @return [Boolean] whether or not the object was created after
      #   that time
      def newer_than?(time)
        created > time
      end

      # @param time [Time] a time that the object is meant to have been
      #   created before
      # @return [Boolean] whether or not the object was created before
      #   that time
      def older_than?(time)
        created < time
      end

      # @!endgroup
      # @!group Modified methods

      # @return [Time] the time the object was last modified
      def modified
        mtime
      end
      # @param date [Date] the date on which the object is meant
      #   to have been last modified
      # @return [Boolean] whether or not the object was last modified
      #   on that date
      def modified_on?(date)
        modified.to_date == date
      end

      # @param date_range [Hastings::DateRange] a range of dates during which the
      #   object is meant to have been last modified
      # @return [Boolean] whether or not the object was last modified
      #   on that date
      def modified_between?(date_range)
        date_range.include? modified.to_date
      end
    end
  end
end
