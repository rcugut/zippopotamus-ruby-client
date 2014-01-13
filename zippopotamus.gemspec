# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zippopotamus/version'

Gem::Specification.new do |spec|
  spec.name          = 'zippopotamus-client'
  spec.version       = Zippopotamus::VERSION
  spec.authors       = ['Radu Cugut']
  spec.email         = ['rcugut@gmail.com']
  spec.description   = %q{Client for zippopotam.us API}
  spec.summary       = %q{Client for zippopotam.us API}
  spec.homepage      = 'https://github.com/rcugut/zippopotamus-ruby-client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr', '~> 2.8.0'
  spec.add_development_dependency 'webmock', '~> 1.15', '< 1.16'

  spec.add_runtime_dependency 'excon', '>= 0', '< 1.0.0'
end
