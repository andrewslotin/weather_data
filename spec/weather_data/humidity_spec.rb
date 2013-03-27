# -*- encoding : utf-8 -*-

require 'spec_helper'

describe WeatherData::Humidity do
  describe ".parse" do
    it "returns an initialized instance of WeatherData::RelativeHumidity" do
      h = described_class.parse("Humidity: 80%")

      expect(h).to be_kind_of WeatherData::Humidity::Relative
      expect(h).to eq 80
    end

    context "if given string does not contain humidity" do
      it "raises ArgumentError" do
        expect { described_class.parse("string") }.to raise_error ArgumentError
      end
    end

    context "if given value 0% or less" do
      it "raises ArgumentError" do
        expect { described_class.parse("0%") }.to raise_error ArgumentError
      end
    end

    context "if given value greater than 100%" do
      it "raises ArgumentError" do
        expect { described_class.parse("101%") }.to raise_error ArgumentError
      end
    end
  end
end