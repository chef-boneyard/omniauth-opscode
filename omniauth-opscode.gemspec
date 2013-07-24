# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/opscode/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-opscode"
  spec.version       = Omniauth::Opscode::VERSION
  spec.authors       = ["Adam Jacob"]
  spec.email         = ["adam@opscode.com"]
  spec.description   = %q{Authenticate via the Opscode Web UI}
  spec.summary       = %q{Authenticate users via the Opscode Web UI username/password}
  spec.homepage      = "http://www.opscode.com"
  spec.license       = "Apache 2"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_dependency "omniauth", "> 1.0"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday-cookie_jar"
end
