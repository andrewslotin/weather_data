# -*- encoding : utf-8 -*-

module WeatherData
  module Temperature
    class Celsius < Base
      def to_celsius
        self
      end

      def to_fahrenheit
        Fahrenheit.new(degrees * 9.0 / 5 + 32)
      end

      def to_kelvin
        Kelvin.new(degrees + 273.15)
      end

      def to_s
        "#{degrees}°C"
      end

      private

      def to_self(value)
        raise ArgumentError unless value.respond_to? :to_celsius
        value.to_celsius
      end
    end
  end
end
