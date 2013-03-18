# -*- encoding : utf-8 -*-

module WeatherData
  module Temperature
    class Kelvin < Base
      def initialize(deg)
        super

        @degrees = 0 if @degrees < 0
      end

      def to_celsius
        Celsius.new(degrees - 273.15)
      end

      def to_fahrenheit
        to_celsius.to_fahrenheit
      end

      def to_kelvin
        self
      end

      private

      def to_self(value)
        raise ArgumentError unless value.respond_to? :to_kelvin
        value.to_kelvin
      end
    end
  end
end
