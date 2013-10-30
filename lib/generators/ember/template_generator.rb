require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class TemplateGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js template."

      def create_template_files
        file_path = File.join(ember_path, 'templates', class_path, "#{file_name}.hbs")
        template 'template.hbs', file_path
      end
    end
  end
end

