# -*- encoding : utf-8 -*-

module WeatherData
  module Temperature
    class Kelvin < Base
      def to_celsius
        Celsius.new(degrees - 273.15)
      end

      def to_fahrenheit
        to_celsius.to_fahrenheit
      end

      def to_kelvin
        self
      end
    end
  end
end
