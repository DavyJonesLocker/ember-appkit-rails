require "rails/generators"
require "rails/generators/rails/resource/resource_generator"
require "generators/ember/controller_generator"
require "generators/ember/view_generator"

module Rails
  module Generators
    ResourceGenerator.class_eval do
      class_option :ember, aliases: '-e', desc: 'force ember resource to generate', optional: true, type: 'boolean', default: false, banner: '--ember'

      def add_ember
        if options.ember
          say_status :invoke, "ember:resource", :white
          with_padding do
            invoke "ember:resource", [singular_name, attributes.map { |a| "#{a.name}:#{a.type}" }].flatten
          end
        end
      end
    end
  end
end
