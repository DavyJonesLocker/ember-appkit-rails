require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class BootstrapGenerator < ::Rails::Generators::Base
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a default Ember.js folder layout in app/assets/javascripts"

      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"

      def inject_ember
        inject_into_application_file
      end


      def create_dir_layout
        %W{models controllers views routes helpers components templates templates/components mixins}.each do |dir|
          empty_directory "#{ember_path}/#{dir}"
          create_file "#{ember_path}/#{dir}/.gitkeep" unless options[:skip_git]
        end
      end

      def create_router_file
        template "router.js.es6", "#{ember_path}/router.js.es6"
      end

      def create_ember_app_file
        template "ember-app.js", "#{ember_path}/ember-app.js"
      end

      private

      def inject_into_application_file
        application_file = "#{ember_path}/application.js"
        inject_into_file( application_file, :before => /^.*require_tree.*$/) do
          context = instance_eval('binding')
          source  = File.expand_path(find_in_source_paths("application.js"))
          ERB.new(::File.binread(source), nil, '-', '@output_buffer').result(context)
        end
      end
    end
  end
end
