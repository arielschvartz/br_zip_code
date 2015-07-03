# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'br_zip_code/version'

Gem::Specification.new do |spec|
  spec.name          = "br_zip_code"
  spec.version       = BrZipCode::VERSION
  spec.authors       = ["Ariel Schvartz"]
  spec.email         = ["ari.shh@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  end

  spec.summary       = "BR Zip Code - #{spec.version}"
  spec.description   = "Gem that lets user find a brazilian address with the given zip_code."
  spec.homepage      = "https://github.com/arielschvartz/br_zip_code"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "dotenv-rails"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
end
