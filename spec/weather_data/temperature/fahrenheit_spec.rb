require 'spec_helper'

describe WeatherData::Temperature::Fahrenheit do
  subject { WeatherData::Temperature::Fahrenheit.new(32) }

  describe "#to_celsius" do
    it "returns degrees in Celsius" do
      expect(subject.to_celsius).to eq 0
    end
  end

  describe "#to_fahrenheit" do
    it "returns self" do
      expect(subject.to_fahrenheit).to eq subject
    end
  end

  describe "#to_kelvin" do
    it "returns degrees in Kelvin" do
      expect(subject.to_kelvin).to eq 273.15
    end
  end
end
