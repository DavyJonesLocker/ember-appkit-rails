$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'ember/appkit/rails/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ember-appkit-rails'
  s.version     = Ember::Appkit::Rails::VERSION
  s.authors     = ['Brian Cardarella']
  s.email       = ['bcardarella@gmail.com']
  s.homepage    = 'https://github.com/dockyard/ember-appkit-rails'
  s.summary     = 'Ember App Kit for Rails'
  s.description = 'Ember App Kit for Rails'

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 4.0'
  s.add_dependency 'parser'
  s.add_dependency 'es6_module_transpiler-rails', '~> 0.4.0'
  s.add_dependency 'ember-source', '~> 1.4.beta'
  s.add_dependency 'ember-data-source', '~> 1.0.0.beta.6'
  s.add_dependency 'handlebars-source'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'barber', '>= 0.4.1'
  s.add_dependency 'active_model_serializers'
  s.add_dependency 'teaspoon', '~> 0.7.9'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock", "< 1.14.0"
end
