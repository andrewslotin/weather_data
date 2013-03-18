module WeatherData
  class Temperature
    CELSIUS    = :C
    FAHRENHEIT = :F
    KELVIN     = :K

    def initialize(degrees, units = CELSIUS)
      @degrees = degrees
      @units   = units
    end

    def to_celsius
    end

    def to_fahrenheit
    end

    def to_kelvin
    end
  end
end
