require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ViewGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js view and associated template."
      class_option :without_template, :type => :boolean, :default => false, :desc => "Create template for this view"

      def create_view_files
        file_path = File.join(app_path, 'views', class_path, "#{file_name}.es6")
        template "view.es6", file_path
        invoke('ember:template', [ name ], options) unless options[:without_template]
      end
    end
  end
end
