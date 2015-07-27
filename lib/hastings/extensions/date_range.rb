module Hastings
  # Date Range class
  class DateRange
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date   = end_date
    end

    def include?(date)
      (@start_date..@end_date).cover?(date)
    end
  end
end
