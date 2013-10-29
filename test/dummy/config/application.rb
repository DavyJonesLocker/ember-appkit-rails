require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)
require 'ember/appkit/rails'
require 'jquery-rails'

module Dummy
  class Application < Rails::Application; end
end

