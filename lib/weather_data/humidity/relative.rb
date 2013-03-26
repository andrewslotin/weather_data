# -*- encoding : utf-8 -*-

require 'delegate'

module WeatherData
  module Humidity
    class Relative < ::SimpleDelegator
      def to_s
        "#{percentage}%"
      end

      protected

      def percentage
        __getobj__
      end
    end
  end
end