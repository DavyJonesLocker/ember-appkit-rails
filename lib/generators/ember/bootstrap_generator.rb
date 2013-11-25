require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class BootstrapGenerator < ::Rails::Generators::Base
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a default Ember.js folder layout in app/assets/javascripts"

      class_option :ember_path, :type => :string, :aliases => "-d", :default => false, :desc => "Custom ember app path"
      class_option :app_name, :type => :string, :aliases => "-n", :default => false, :desc => "Custom ember app name"
      class_option :leave_turbolinks, :type => :boolean, :default => false, :desc => "Leave 'turbolinks' in Gemfile"
      class_option :leave_jqueryujs, :type => :boolean, :default => false, :desc => "Leave 'jquery_ujs' in application.js"

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

      def remove_turbolinks
        return if options[:leave_turbolinks]

        remove_turbolinks_from_gemfile
        remove_turbolinks_from_layout
        remove_turbolinks_from_application_js
      end

      def remove_jquery_ujs
        return if options[:leave_jqueryujs]

        path = Pathname.new(destination_root).join('app','assets','javascripts','application.js')
        return unless path.exist?

        gsub_file path, /(?:\/\/= require jquery_ujs)\n/, ''
      end

      def create_ember_store_file
        template "store.js", "#{ember_path}/store.js"
      end

      def create_ember_env_file
        template "ember-env.js", "#{ember_path}/ember-env.js"
      end

      private

      def remove_turbolinks_from_application_js
        path = Pathname.new(destination_root).join('app','assets','javascripts','application.js')
        return unless path.exist?

        gsub_file path, /(?:\/\/= require turbolinks)\n/, ''
      end

      def remove_turbolinks_from_layout
        path = Pathname.new(destination_root).join('app','views','layouts','application.html.erb')
        return unless path.exist?

        gsub_file path, /(?:, "data-turbolinks-track" => true)/, ''
      end

      def remove_turbolinks_from_gemfile
        path = Pathname.new(destination_root).join('Gemfile')
        return unless path.exist?

        gsub_file path, /(?:#.+$\n)?gem 'turbolinks'\n/, ''
      end

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
