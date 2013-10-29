module Ember
  module Appkit
    module Rails
      class Engine < ::Rails::Engine
        config.handlebars ||= ActiveSupport::OrderedOptions.new

        config.handlebars.output_type = :amd
        config.handlebars.amd_namespace = 'appkit'
      end
    end
  end
end
