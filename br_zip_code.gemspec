$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "br_zip_code/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "br_zip_code"
  s.version     = BrZipCode::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of BrZipCode."
  s.description = "TODO: Description of BrZipCode."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
