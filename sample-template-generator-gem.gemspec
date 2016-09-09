# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seek/sample_templates/version'


Gem::Specification.new do |spec|
  spec.name          = "sample-template-generator-gem"
  spec.version       = Seek::SampleTemplates::VERSION
  spec.authors       = ["Stuart Owen"]
  spec.email         = ["stuart.owen@manchester.ac.uk"]

  spec.summary       = %q{Prototype for generating spreadsheet templates for use with SEEK.}
  spec.homepage      = "http://seek4science.org"
  spec.license       = "BSD-3-Clause" # https://spdx.org/licenses/BSD-3-Clause.html#licenseText

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency(%q<open4>, ["= 1.3.0"])
  spec.add_dependency(%q<rdoc>, [">= 0"])

  spec.add_development_dependency(%q<rubocop>, [">= 0"])
  spec.add_development_dependency(%q<rubycritic>, [">= 0"])
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
