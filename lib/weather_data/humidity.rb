# -*- encoding : utf-8 -*-

require "weather_data/humidity/relative"

module WeatherData
  module Humidity
    def self.parse(s)
      _, points, units = /\b(\d+(?:\.\d+)?)%/.match(s).to_a

      raise ArgumentError.new(%Q{"#{s.inspect}" doesn't contain humidity}) unless points

      percents = points.to_f
      raise ArgumentError.new("Invalid value for relative humidity: #{percents.inspect}") unless percents > 0 && percents <= 100

      Relative.new(percents)
    end
  end
end