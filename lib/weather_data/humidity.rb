# -*- encoding : utf-8 -*-

require "weather_data/humidity/relative"

module WeatherData
  module Humidity
    def self.parse(s)
      _, points, units = /\b(\d+(?:\.\d+)?)(%)?\B/.match(s).to_a

      raise ArgumentError.new("#{s.inspect} doesn't contain humidity") unless points && points.to_f > 0.0
      points = points.to_f * 100.0 unless units == '%'

      Relative.new(points.to_f)
    end
  end
end