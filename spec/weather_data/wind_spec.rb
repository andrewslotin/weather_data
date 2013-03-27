# -*- encoding : utf-8 -*-

require 'spec_helper'

describe WeatherData::Wind do
  subject { described_class.new(1) }

  describe ".parse" do
  end

  describe "#initialize" do
  end

  describe "#to_kmh" do
    it "returns speed in km/h" do
      expect(subject.to_kmh).to eq 3.6
    end
  end
end