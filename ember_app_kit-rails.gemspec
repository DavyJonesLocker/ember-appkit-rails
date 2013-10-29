$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'ember_app_kit/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ember_app_kit-rails'
  s.version     = EmberAppKit::VERSION
  s.authors     = ['Brian Cardarella']
  s.email       = ['bcardarella@gmail.com']
  s.homepage    = 'https://github.com/dockyard/ember_app_kit-rails'
  s.summary     = 'Ember App Kit for Rails'
  s.description = 'Ember App Kit for Rails'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.0.0'
  s.add_dependency 'es6_module_transpiler-rails', '~> 0.0.3'

  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'ember-rails'
  s.add_development_dependency 'ember-source'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'byebug'
end
