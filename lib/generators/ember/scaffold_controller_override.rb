require 'rails/generators'
require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module Rails
  module Generators
    class ScaffoldControllerGenerator
      source_root File.expand_path('../../templates/scaffold_controller', __FILE__)

      def create_controller_files
        template "controller.rb", File.join("app/controllers/api/v#{::Rails.application.config.ember.api_version}", class_path, "#{controller_file_name}_controller.rb")
      end
    end
  end
end
