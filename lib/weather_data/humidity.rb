# -*- encoding : utf-8 -*-

require "weather_data/humidity/relative"

module WeatherData
  module Humidity
    def self.parse(s)
      percents = s[/\b(\d+)%\B/, 1]

      raise ArgumentError unless percents && percents.to_f >= 0.0

      Relative.new(percents.to_f)
    end
  end
end