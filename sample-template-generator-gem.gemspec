# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seek/sample_templates/version'

Gem::Specification.new do |spec|
  spec.name          = 'sample-template-generator'
  spec.version       = Seek::SampleTemplates::VERSION
  spec.authors       = ['Stuart Owen']
  spec.email         = ['stuart.owen@manchester.ac.uk']

  spec.summary       = 'Bespoke tool for generating spreadsheet templates from Sample Types for use with SEEK.'
  spec.homepage      = 'http://seek4science.org'
  spec.license       = 'BSD-3-Clause'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('rdoc', ['~> 6.0'])
  spec.add_dependency('terrapin', ['~> 0.6'])

  spec.add_development_dependency('rubocop', ['~> 1.25'])
  spec.add_development_dependency 'bundler', '~> 2.4'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest', '~> 5.1'
  spec.add_development_dependency('activesupport', "~> 6.1")
end
