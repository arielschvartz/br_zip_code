$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "br_zip_code/version"
require "httparty"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "br_zip_code"
  s.version     = BrZipCode::VERSION
  s.authors     = ["Ariel Schvartz"]
  s.email       = ["ari.shh@gmail.com"]
  s.homepage    = "https://github.com/arielschvartz"
  s.summary     = "BR Zip Code - #{s.version}"
  s.description = "Gem that lets user find a brazilian address with the given zip_code."

  s.files = `git ls-files`.split("n")
  s.require_path = 'lib'

  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency "httparty", "~> 0.12.0"

  s.add_development_dependency "sqlite3"

end
