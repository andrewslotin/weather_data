# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weather_data/version'

Gem::Specification.new do |gem|
  gem.name          = "weather_data"
  gem.version       = WeatherData::VERSION
  gem.authors       = ["Andrew Slotin"]
  gem.email         = ["andrew.slotin@gmail.com"]
  gem.description   = %q{Simple weather data manipulation}
  gem.summary       = %q{Provides conversion between temperature units etc.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')
end
