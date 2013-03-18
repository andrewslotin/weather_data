require 'spec_helper'

describe WeatherData::Temperature::Kelvin do
  subject { WeatherData::Temperature::Kelvin.new(273.15) }

  describe "#to_celsius" do
    it "returns degrees in Celsius" do
      expect(subject.to_celsius).to eq 0
    end
  end

  describe "#to_fahrenheit" do
    it "returns degrees in Fahrenheit" do
      expect(subject.to_fahrenheit).to eq 32
    end
  end

  describe "#to_kelvin" do
    it "returns self" do
      expect(subject.to_kelvin).to eq subject
    end
  end
end
