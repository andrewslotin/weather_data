# -*- encoding : utf-8 -*-

require 'spec_helper'

describe WeatherData::Weather do
  subject { described_class.new(:temperature => "+30C", :humidity => "60%") }

  describe ".parse" do
    it "returns an instance of WeatherData::Weather" do
      expect(described_class.parse("10C, 40%")).to be_an_instance_of described_class
    end

    it "initializes temperature" do
      expect(described_class.parse("10C, 40%").temperature).to eq 10
    end

    it "initializes humidity" do
      expect(described_class.parse("10C, 40%").humidity).to eq 40
    end
  end

  describe "#dew_point" do
    it "returns dew point based on Magnus formula" do
      expect(subject.dew_point.to_celsius.degrees.round).to eq 21
    end
  end

  describe "#humindex" do
    before do
      subject.stub(:dew_point).and_return WeatherData::Temperature::Celsius.new(15)
    end

    it "returns humindex" do
      expect(subject.humindex.to_celsius.degrees.round).to eq 34
    end
  end

  describe "#vapour_pressure" do
    it "returns vapour pressure in hPa for given conditions" do
      expect(subject.vapour_pressure.round).to eq ((42 * subject.humidity / 100.0).round)
    end
  end

  describe "#apparent_temperature" do
    before do
      subject.stub(
        :temperature => WeatherData::Temperature::Celsius.new(18),
        :humidity    => WeatherData::Humidity::Relative.new(70),
        :wind        => WeatherData::Wind.new(10, "km/h")
      )
    end

    it "returns Australian apparent temperature for given conditions" do
      expect(subject.apparent_temperature.to_celsius.degrees.round).to eq 17
    end
  end
end