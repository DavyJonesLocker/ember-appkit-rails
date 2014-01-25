require "rails/generators"
require "generators/serializer/serializer_generator"

module Rails
  module Generators
    SerializerGenerator.class_eval do
      def create_serializer_file
        template 'serializer.rb', File.join('config/serializers', class_path, "#{file_name}_serializer.rb")
      end
    end
  end
end
