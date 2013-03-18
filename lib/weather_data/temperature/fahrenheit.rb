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
    end
  end
end
