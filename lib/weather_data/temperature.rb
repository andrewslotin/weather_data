# -*- encoding : utf-8 -*-

require "weather_data/temperature/base"
require "weather_data/temperature/celsius"
require "weather_data/temperature/fahrenheit"
require "weather_data/temperature/kelvin"

module WeatherData
  module Temperature
    CELSIUS    = :C
    FAHRENHEIT = :F
    KELVIN     = :K

    def self.parse(s)
      degrees, units = s.match(/\A\s*([+-]?\d+(?:\.\d+)?)\s*(°?#{CELSIUS}|°?#{FAHRENHEIT}|#{KELVIN})\b/).to_a[1..2]

      raise ArgumentError unless degrees && units

      units_class(units).new(degrees.to_f)
    end

    private

    def self.units_class(units)
      case units.gsub(/\A°/, '').to_sym
      when CELSIUS
        Celsius
      when FAHRENHEIT
        Fahrenheit
      when KELVIN
        Kelvin
      else
        raise ArgumentError.new(units)
      end
    end
  end
end
