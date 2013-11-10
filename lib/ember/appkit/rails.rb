require 'ember-rails'
require 'ember/source'
require 'ember/appkit/rails/engine'
require 'es6_module_transpiler/rails'

Rails::WelcomeController.view_paths = File.expand_path('../rails/templates', __FILE__)
