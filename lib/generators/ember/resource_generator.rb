require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ResourceGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js router, controller, view and template"

      class_option :skip_route, :type => :boolean, :default => false, :desc => "Don't create route"
      class_option :array, :type => :boolean, :default => false, :desc => "Create an Ember.ArrayController to represent multiple objects"
      class_option :object, :type => :boolean, :default => false, :desc => "Create an Ember.ObjectController to represent a single object"

      def create_resource_files
        unless options[:skip_route]
          invoke('ember:route', [ name ], options)
          inject_into_router_file(name)
        end
        invoke('ember:controller', [ name ], options)
        invoke('ember:template', [ name ], options)
      end

      private

      def inject_into_router_file(name)
        router_file = "#{config_path}/router.js.es6"
        inject_into_file(router_file, :after => /^.*Router.map\(function\(\) \{*$/) do
          "\n  this.resource('#{name.pluralize}');"
        end
      end
    end
  end
end

