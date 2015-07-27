module Hastings
  module Dsl
    # Date
    module DateTime
      def date(date_str = nil, format = nil)
        date_str ? parse(Date, date_str, format) : Date
      end

      def time(time_str, format = nil)
        time_str ? parse(Time, time_str, format) : Time
      end

      private

        def parse(klass, string, format = nil)
          format ? klass.strptime(string, format) : klass.parse(string)
        end
    end
  end
end
