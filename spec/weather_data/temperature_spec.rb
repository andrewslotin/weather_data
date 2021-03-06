# -*- encoding : utf-8 -*-

require 'spec_helper'

describe WeatherData::Temperature do
  [0, 0.0].each do |number|
    describe "extends #{number.class}" do
      {
        :celsius    => WeatherData::Temperature::Celsius,
        :fahrenheit => WeatherData::Temperature::Fahrenheit,
        :kelvin     => WeatherData::Temperature::Kelvin
      }.each do |method_name, klass|
        it "adds #{method_name}" do
          expect(number).to respond_to(method_name)
        end

        it "#{method_name} returns an instance of #{klass.name}" do
          expect(number.send(method_name)).to be_kind_of klass
          expect(number.send(method_name).degrees).to eq number
        end
      end
    end
  end

  describe "#parse" do
    it "parses temperature in Celsius" do
      [15.2, -15.2].each do |deg|
        ["#{deg} °C", "#{deg}°C", "#{deg}C", "#{deg} C", "Temperature: #{deg}°C"].each do |s|
          t = subject.parse(s)
          expect(t).to be_kind_of WeatherData::Temperature::Celsius
          expect(t).to eq deg
        end
      end
    end

    it "parses temperature in Fahrenheit" do
      [15.2, -15.2].each do |deg|
        ["#{deg} °F", "#{deg}°F", "#{deg}F", "#{deg} F", "Temperature: #{deg}°F"].each do |s|
          t = subject.parse(s)
          expect(t).to be_kind_of WeatherData::Temperature::Fahrenheit
          expect(t).to eq deg
        end
      end
    end

    it "parses temperature in Kelvin" do
      ["15.2K", "15.2 K"].each do |s|
        t = subject.parse(s)
        expect(t).to be_kind_of WeatherData::Temperature::Kelvin
        expect(t).to eq 15.2
      end
    end

    context "when there is no temperature within given string" do
      it "raises ArgumentError" do
        expect { subject.parse("bogus string") }.to raise_error ArgumentError
      end
    end
  end
end
