require 'rails/generators'

module Ember
  module Generators
    module GeneratorHelpers

      def app_path
        if options[:app_path]
          options[:app_path]
        else
          configuration.paths.app
        end
      end

      def config_path
        if options[:config_path]
          options[:config_path]
        else
          configuration.paths.config
        end
      end

      def rails_engine?
        defined?(ENGINE_PATH)
      end

      def engine_name
        ENGINE_PATH.split('/')[-2]
      end

      def application_name
        if options[:app_name]
          options[:app_name]
        elsif configuration.app_name
          configuration.app_name
        elsif rails_engine?
          engine_name
        else
          'App'
        end
      end

      def class_name
        (class_path + [file_name]).map!{ |m| m.camelize }.join()
      end

      def handlebars_template_path
        File.join(class_path, file_name).gsub(/^\//, '')
      end

      def javascript_assets_path
        File.join(::Rails.root, 'app/assets/javascripts')
      end

      def configuration
        ::Rails.configuration.ember.appkit
      end
    end
  end
end
