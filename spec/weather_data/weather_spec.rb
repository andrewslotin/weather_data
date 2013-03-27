# -*- encoding : utf-8 -*-

require 'spec_helper'

describe WeatherData::Weather do
  subject { described_class.new(temperature: "+30C", humidity: "60%") }

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
end