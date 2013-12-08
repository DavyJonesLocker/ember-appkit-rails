require 'rails/generators'
require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module Rails
  module Generators
    class ScaffoldControllerGenerator
      source_root File.expand_path('../../templates/scaffold_controller', __FILE__)
    end
  end
end
