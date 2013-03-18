# -*- encoding : utf-8 -*-

module WeatherData
  module Temperature
    class Base
      attr_accessor :degrees

      def initialize(deg)
        @degrees = if deg.is_a? Numeric
          deg.to_f
        else
          to_self(deg).degrees
        end
      end

      def ==(value)
        if value.is_a? Numeric
          degrees == value
        else
          super
        end
      end

      def -@
        self.class.new(-degrees)
      end

      def +(value)
        self.class.new(degrees + to_self(value).degrees)
      end

      def -(value)
        -(-self + value)
      end

      def *(value)
        self.class.new(value * degrees)
      end

      def /(value)
        self.class.new(value * (1 / degrees))
      end

      def to_i
        degrees.round
      end

      def to_f
        degrees
      end

      private

      def to_self(value)
        value
      end
    end
  end
end
