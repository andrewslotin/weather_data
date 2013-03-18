# -*- encoding : utf-8 -*-

module WeatherData
  module Temperature
    class Base
      attr_accessor :degrees

      def initialize(deg)
        @degrees = deg
      end

      def ==(value)
        if value.is_a? Numeric
          degrees == value
        else
          super
        end
      end

      def to_i
        degrees.round
      end

      def to_f
        degrees
      end
    end
  end
end
