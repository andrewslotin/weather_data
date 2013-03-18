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
    end
  end
end
