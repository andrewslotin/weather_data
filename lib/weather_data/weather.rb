# -*- encoding : utf-8 -*-

require "weather_data/temperature"
require "weather_data/humidity"
require "weather_data/wind"

module WeatherData
  class Weather
    ATTRIBUTES = [
      :temperature,
      :humidity,
      :wind
    ].freeze

    attr_accessor *ATTRIBUTES

    def self.parse(s)
      attributes = {}.tap do |attrs|
        {
          :temperature => Temperature, 
          :humidity    => Humidity, 
          :wind        => Wind
        }.each do |attr, parser|
          begin
            attrs[attr] = parser.parse(s)
          rescue ArgumentError
          end
        end
      end

      raise ArgumentError.new(%Q{"#{s}" doesn't contain weather data}) if attributes.empty?

      new(attributes)
    end

    def initialize(attributes = {})
      ATTRIBUTES.each do |attr|
        self.send(:"#{attr}=", attributes[attr])
      end
    end

    def dew_point
      if humidity && temperature
        t       = temperature.to_celsius.degrees
        a, b, c = magnus_formula_constants(t)
        gamma   = Math.log(humidity / 100) + b * t / (c + t)

        Temperature::Celsius.new(c * gamma / (b - gamma))
      end
    end

    def vapour_pressure
      if humidity
        t = temperature.to_celsius.degrees
        (humidity / 100.0) * 6.105 * Math.exp(17.27 * t / (237.7 + t))
      end
    end

    def humindex
      if temperature && dew_point
        t = temperature.to_celsius.degrees + 0.5555 * (6.11 * Math.exp(5417.753 * (1 / 273.16 - 1 / dew_point.to_kelvin.degrees)) - 10)
        t.celsius
      end
    end

    def apparent_temperature
      if vapour_pressure && temperature
        t = temperature.to_celsius.degrees
        Temperature::Celsius.new(t + 0.33 * vapour_pressure - 0.7 * wind.to_f - 4.0)
      end
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