# -*- encoding : utf-8 -*-

require 'delegate'

module WeatherData
  class Wind < ::SimpleDelegator
    ATTRIBUTES = [
      :direction,
      :speed,
      :units
    ].freeze

    CARDINAL_DIRECTIONS = {
      :N   => 0.0,
      :NNE => 22.5,
      :NE  => 45.0,
      :ENE => 67.5,
      :E   => 90.0,
      :ESE => 112.5,
      :SE  => 135.0,
      :SSE => 157.5,
      :S   => 180.0,
      :SSW => 202.5,
      :SW  => 225.0,
      :WSW => 247.5,
      :W   => 270.0,
      :WNW => 292.5,
      :NW  => 315.0,
      :NNW => 337.5
    }.freeze

    attr_accessor *ATTRIBUTES

    def self.parse(s)
      _, speed, units = /(\d+(?:\.\d+)?)\s*(m\/?s(?:ec)?|km\/?h(?:our)?)/i.match(s).to_a
      units ||= "m/s"

      raise ArgumentError.new(%Q{"#{s.inspect}" doesn't contain wind speed}) unless speed

      _, direction = /(#{CARDINAL_DIRECTIONS.keys.join('|')})/.match(s).to_a

      new(speed.to_f, units, direction)
    end

    def initialize(speed, units = "m/s", azimuth_or_direction = nil)
      super normalize_speed(speed, units)
      @direction = to_direction(azimuth_or_direction) if azimuth_or_direction
    end

    def speed
      __getobj__
    end

    def speed=(value)
      __setobj__(value)
    end

    def to_kmh
      speed * 3.6
    end

    def to_s
      ["#{speed} #{units}", direction].compact.join(" ")
    end

    protected

    def normalize_speed(speed, units)
      if units.downcase.gsub('/', '') == 'kmh'
        speed / 3.6
      else
        speed
      end
    end

    def to_direction(azimuth_or_direction)
      if azimuth_or_direction.is_a? Numeric
        d = (azimuth_or_direction + 360) % 360

        unless d >= 0 && d < 360
          raise ArgumentError.new("Invalid azimuth for wind direction: #{azimuth_or_direction.inspect}")
        end

        CARDINAL_DIRECTIONS.find { |direction, azimuth| (d - azimuth).abs < 22.5 }.first
      else
        d = azimuth_or_direction.upcase.gsub('/', '').to_sym

        unless CARDINAL_DIRECTIONS.has_key? d
          raise ArgumentError.new("Invalid azimuth for wind direction: #{azimuth_or_direction.inspect}")
        end

        d
      end
    end
  end
end