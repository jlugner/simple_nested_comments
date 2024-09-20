$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_nested_comments/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_nested_comments"
  s.version     = SimpleNestedComments::VERSION
  s.authors     = ["Robert Johansson"]
  s.email       = ["no-email@please.com"]
  s.summary     = "Add simple_nested comments to your models."
  s.description = "Adding nested comments to your models. This gem is an engine and supplies helpers to add the nested comments to your views."
  s.license       = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # Supports Rails 4.0 and 5.0
  s.add_dependency "rails", ">= 4.0"
  s.add_runtime_dependency 'ancestry'
  s.add_dependency 'haml'

  s.add_development_dependency "sqlite3"
end
