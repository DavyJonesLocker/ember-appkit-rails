$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'ember/appkit/rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ember-appkit-rails'
  s.version     = Ember::Appkit::Rails::VERSION
  s.authors     = ['Brian Cardarella']
  s.email       = ['bcardarella@gmail.com']
  s.homepage    = 'https://github.com/dockyard/ember_app_kit-rails'
  s.summary     = 'Ember App Kit for Rails'
  s.description = 'Ember App Kit for Rails'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.0.0'
  s.add_dependency 'es6_module_transpiler-rails', '~> 0.0.3'
  s.add_dependency 'ember-rails'
  s.add_dependency 'ember-source', '~> 1.2.0.beta.2'

  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'byebug'
end
