require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a new Ember.js component and component template\nCustom Ember Components require at least two descriptive names separated by a dash. Use CamelCase or dash-case to name your component.\n\nExample,\n\trails generate ember:component PostChart [options]\n\trails generate ember:component post-chart [options]"

      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"

      def create_component_files
        dashed_file_name = file_name.gsub(/_/, '-')
        component_path = File.join(ember_path, 'components', class_path, "#{dashed_file_name}_component.js.es6")
        template "component.js.es6", component_path

        template_path = File.join(ember_path, 'templates/components', class_path, "#{dashed_file_name}.hbs")
        template "component.template.hbs", template_path
      end
    end
  end
end
