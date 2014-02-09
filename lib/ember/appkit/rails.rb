require 'jquery-rails'
require 'ember/source'
require 'es6_module_transpiler/rails'
require 'active_model_serializers'
require 'sprockets/railtie'
require 'ember/source'
require 'ember/data/source'
require 'handlebars/source'

module Ember
  module Appkit
    module Rails; end
  end
end

require 'ember/appkit/rails/engine'
require 'ember/appkit/rails/sprockets'
require 'ember/appkit/rails/template'
require 'ember/appkit/rails/active_support'

if [:development, :test].include?(Rails.env.to_sym)
  require 'ember/appkit/rails/teaspoon'
end
