require 'rails/generators'
require 'rails/generators/rails/scaffold/scaffold_generator'
require 'ember/appkit/rails/walker'

module Rails
  module Generators
    class ScaffoldGenerator
      class_option :ember, aliases: '-e', desc: 'force ember resource to generate', optional: true, type: 'boolean', default: false, banner: '--ember'
      remove_hook_for :resource_route

      def add_ember
        if options.ember
          say_status :invoke, "ember:resource", :white
          with_padding do
            invoke "ember:scaffold", [singular_name, attributes.map { |a| "#{a.name}:#{a.type}" }].flatten
          end
        end
      end

      def write_resource
        Walker.new(file_path.pluralize, File.join(destination_root, 'config/routes.rb'), ::Rails.application.config.ember.api_version).run
      end
    end
  end
end
