require 'spec_helper'

describe WeatherData::Temperature do
  describe "#initialize" do
    let(:subject) { WeatherData::Temperature }

    it "initializes degrees" do
      o = subject.new(10, subject::FAHRENHEIT)

      expect(o.instance_variable_get(:@degrees)).to eq 10
    end

    it "initializes units" do
      o = subject.new(10, subject::FAHRENHEIT)

      expect(o.instance_variable_get(:@units)).to eq subject::FAHRENHEIT
    end

    context "when units is not set" do
      it "initializes units with #{WeatherData::Temperature::CELSIUS.inspect}" do
        o = subject.new(10)

        expect(o.instance_variable_get(:@units)).to eq subject::CELSIUS
      end
    end
  end
end
