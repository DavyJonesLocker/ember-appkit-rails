require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class RouteGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js route"

      def create_route_files
        file_path = File.join(app_path, 'routes', class_path, "#{file_name}.js.es6")
        template "route.js.es6", file_path
      end
    end
  end
end

