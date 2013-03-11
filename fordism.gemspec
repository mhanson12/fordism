# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fordism/version'

Gem::Specification.new do |gem|
  gem.name          = "fordism"
  gem.version       = Fordism::VERSION
  gem.authors       = ["Matt Hanson"]
  gem.email         = ["matthew.hanson@zazzle.com"]
  gem.description   = %q{A powerful workflow generator modeled off Fordist production strategies}
  gem.summary       = %q{Easily generate workflows that support auto-running, interrupts, concurrent processing and integrate seamlessly into your rails app.}
  gem.homepage      = ""

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rgl"
  

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
