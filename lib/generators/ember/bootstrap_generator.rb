require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class BootstrapGenerator < ::Rails::Generators::Base
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a default Ember.js folder layout in app/assets/javascripts"

      class_option :app_path, :type => :string, :aliases => "-a", :default => false, :desc => "Custom ember app path"
      class_option :config_path, :type => :string, :aliases => "-c", :default => false, :desc => "Custom ember config path"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"

      def create_dir_layout
        %W{routes components templates templates/components mixins}.each do |dir|
          empty_directory "#{app_path}/#{dir}"
          create_file "#{app_path}/#{dir}/.gitkeep" unless options[:skip_git]
        end
      end

      def remove_javascript_assets_directory
        remove_dir "app/assets/javascripts"
      end

      def create_router_file
        template "router.js.es6", "#{config_path}/router.js.es6"
      end

      def create_application_file
        template "application.js.erb", "#{config_path}/application.js"
      end

      def create_ember_adapter_file
        template "adapter.js", "#{config_path}/adapter.js"
      end

      def create_ember_environment_files
        template "environment.js", "#{config_path}/environment.js"
        template "environments/development.js", "#{config_path}/environments/development.js"
        template "environments/production.js", "#{config_path}/environments/production.js"
        template "environments/test.js", "#{config_path}/environments/test.js"
      end

      def create_utils_csrf_file
        template "csrf.js", "#{config_path}/initializers/csrf.js"
      end

      def remove_turbolinks
        remove_turbolinks_from_gemfile
        remove_turbolinks_from_layout
      end

      def add_custom_paths
        if app_path != configuration.paths.app
          insert_into_file 'config/application.rb', before: /\s\send\nend/ do
            "    config.ember.appkit.paths.app = '#{app_path}'\n"
          end
        end

        if config_path != configuration.paths.config
          insert_into_file 'config/application.rb', before: /\s\send\nend/ do
            "    config.ember.appkit.paths.config = '#{config_path}'\n"
          end
        end
      end

      def add_generator_options
        insert_into_file 'config/application.rb', before: /\s\send\nend/ do
          "    config.generators do |generate|\n" +
          "      generate.assets false\n" +
          "      generate.helper false\n" +
          "      generate.jbuilder false\n" +
          "      generate.template_engine false\n" +
          "    end\n"
        end
      end

      private

      def remove_turbolinks_from_layout
        path = Pathname.new(destination_root).join('app','views','layouts','application.html.erb')
        return unless path.exist?

        gsub_file path, /(?:, "data-turbolinks-track" => true)/, ''
      end

      def remove_turbolinks_from_gemfile
        path = Pathname.new(destination_root).join('Gemfile')
        return unless path.exist?

        gsub_file path, /(?:#.+$\n)?gem 'turbolinks'\n\n/, ''
      end
    end
  end
end
