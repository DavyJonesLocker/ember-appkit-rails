require 'rails/generators'
require 'rails/generators/rails/scaffold/scaffold_generator'
require 'ember/appkit/rails/walker'

module Rails
  module Generators
    class ScaffoldGenerator
      remove_hook_for :resource_route

      def write_resource
        Walker.new(file_path.pluralize, File.join(destination_root, 'config/routes.rb'), ::Rails.application.config.ember.api_version).run
      end
    end
  end
end
