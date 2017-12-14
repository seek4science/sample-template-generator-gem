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

  spec.add_dependency('rdoc', ['>= 6.0'])
  spec.add_dependency('cocaine', ['>= 0.5'])

  spec.add_development_dependency('rubocop', ['>= 0.48'])
  spec.add_development_dependency('rubycritic', ['>= 3.2'])
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency('activesupport', ">= 4.0.0", "< 5.0")
end
