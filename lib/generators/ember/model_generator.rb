require 'generators/ember/generator_helpers'

module Ember
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      include Ember::Generators::GeneratorHelpers

      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates a new ember.js model"
      argument :attributes, :type => :array, :default => [], :banner => "field[:type] field[:type] ..."

      def create_model_files
        file_path = File.join(app_path, 'models', class_path, "#{file_name}.js.es6")
        template "model.js.es6", file_path
      end

      private

      EMBER_TYPE_LOOKUP = {
        nil  => 'string',
        :binary => 'string',
        :string => 'string',
        :text => 'string',
        :boolean => 'boolean',
        :date => 'date',
        :datetime =>'date',
        :time => 'date',
        :timestamp => 'date',
        :decimal => 'number',
        :float => 'number',
        :integer => 'number',
        :primary_key => 'number'
      }

      def parse_attributes!
        self.attributes = (attributes || []).map do |attr|
          name, type = attr.split(':')
          key = type.try(:to_sym)
          ember_type = EMBER_TYPE_LOOKUP[key] || type

          { :name => name, :type => ember_type }
        end
      end
    end
  end
end
