# -*- encoding : utf-8 -*-

require "weather_data/temperature"
require "weather_data/humidity"

module WeatherData
  class Weather
    ATTRIBUTES = [
      :temperature,
      :humidity
    ].freeze

    attr_accessor *ATTRIBUTES

    def self.parse(s)
      new(temperature: Temperature.parse(s), humidity: Humidity.parse(s))
    end

    def initialize(attributes = {})
      ATTRIBUTES.each do |attr|
        self.send(:"#{attr}=", attributes[attr])
      end
    end

    def dew_point
      t       = temperature.to_celsius.degrees
      a, b, c = magnus_formula_constants(t)
      gamma   = Math.log(humidity / 100) + b * t / (c + t)

      Temperature::Celsius.new(c * gamma / (b - gamma))
    end

    def humindex
      t = temperature.to_celsius.degrees + 0.5555 * (6.11 * Math.exp(5417.753 * (1 / 273.16 - 1 / dew_point.to_kelvin.degrees)) - 10)
      t.celsius
    end

    def temperature=(value)
      @temperature = case value
      when String
        Temperature.parse(value)
      when Temperature::Base
        value
      else
        raise ArgumentError.new(%Q{#{value.inspect} must be String or kind of WeatherData::Temperature::Base})
      end
    end

    def humidity=(value)
      @humidity = case value
      when String
        Humidity.parse(value)
      when Humidity::Relative
        value
      else
        raise ArgumentError.new(%Q{#{value.inspect} must be String or an instance of WeatherData::Humidity::Relative})
      end
    end

    private

    def magnus_formula_constants(temperature)
      if temperature > 0
        [6.1121, 17.368, 238.88]
      else
        [6.1121, 17.966, 247.15]
      end
    end
  end
end