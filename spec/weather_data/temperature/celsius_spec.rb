require 'spec_helper'

describe WeatherData::Temperature::Celsius do
  subject { WeatherData::Temperature::Celsius.new(0) }

  describe "#to_celsius" do
    it "returns self" do
      expect(subject.to_celsius).to eq subject
    end
  end

  describe "#to_fahrenheit" do
    it "returns degrees in Fahrenheit" do
      expect(subject.to_fahrenheit).to eq 32
    end
  end

  describe "#to_kelvin" do
    it "returns degrees in Kelvin" do
      expect(subject.to_kelvin).to eq 273.15
    end
  end
end
