require "rails/generators"

begin
require "generators/serializer/serializer_generator"
rescue LoadError
# TODO: Make this primary when active_model_serializers 0.9.0 is final
require "active_model/serializer/generators/serializer/serializer_generator"
end

module Rails
  module Generators
    SerializerGenerator.class_eval do
      def create_serializer_file
        template 'serializer.rb', File.join('config/serializers', class_path, "#{file_name}_serializer.rb")
      end
    end
  end
end
