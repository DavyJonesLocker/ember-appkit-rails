module Ember::Appkit::Rails; end

require 'ember/appkit/rails/engine'
require 'ember/appkit/rails/sprockets'

Rails::WelcomeController.view_paths = File.expand_path('../rails/templates', __FILE__)
