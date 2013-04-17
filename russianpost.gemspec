# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'russianpost/version'

Gem::Specification.new do |spec|
  spec.name          = "russianpost"
  spec.version       = Russianpost::VERSION
  spec.authors       = ["Artem Shitov"]
  spec.email         = ["inbox@artemshitov.ru"]
  spec.description   = %q{Thin wrapper around Russian Post package tracking SOAP API. Works on a per-package basis (contrary to the bulk ticket-based API). Use it at your own risk, since the API may appear unstable and require authorization in future.}
  spec.summary       = %q{Russian Post package tracking API client}
  spec.homepage      = "https://github.com/artemshitov/russianpost"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "savon"
end
