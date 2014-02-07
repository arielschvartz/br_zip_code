$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "br_zip_code/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "br_zip_code"
  s.version     = BrZipCode::VERSION
  s.authors     = ["Ariel Schvartz"]
  s.email       = ["ari.shh@gmail.com"]
  s.homepage    = "https://github.com/arielschvartz"
  s.summary     = "Need to do tests."
  s.description = "Gem that lets user find a brazilian address with the given zip_code."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2.14"
  s.add_runtime_dependency "httparty"

  s.add_development_dependency "sqlite3"

end
