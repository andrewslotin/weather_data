# -*- encoding : utf-8 -*-

module WeatherData
  module Temperature
    class Fahrenheit < Base
      def to_celsius
        Celsius.new((degrees - 32) * 5.0 / 9)
      end

      def to_fahrenheit
        self
      end

      def to_kelvin
        to_celsius.to_kelvin
      end

      private

      def to_self(value)
        raise ArgumentError unless value.respond_to? :to_fahrenheit
        value.to_fahrenheit
      end
    end
  end
end
