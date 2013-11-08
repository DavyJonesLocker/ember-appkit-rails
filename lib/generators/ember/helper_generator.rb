require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class HelperGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)
      argument :name, :type => :string, :desc => 'Create an Ember.Handlebars.helper'

      def create_helper_files
        file_path = File.join(ember_path, 'helpers', class_path, "#{file_name}.js")
        template 'helper.js', file_path
      end
    end
  end
end
