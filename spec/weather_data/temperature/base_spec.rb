require 'spec_helper'

describe WeatherData::Temperature::Base do
  subject { WeatherData::Temperature::Base }

  describe "#initialize" do
    it "initializes degrees" do
      o = subject.new(10)

      expect(o.instance_variable_get(:@degrees)).to eq 10
    end
  end

  describe "#to_i" do
    it "returns degrees rounded" do
      expect(subject.new(15.6).to_i).to eq 16
      expect(subject.new(15.1).to_i).to eq 15
    end
  end

  describe "#to_f" do
    it "returns degrees" do
      expect(subject.new(15.6).to_f).to eq 15.6
      expect(subject.new(15.1).to_f).to eq 15.1
    end
  end
end
