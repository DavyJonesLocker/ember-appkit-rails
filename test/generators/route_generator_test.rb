require 'test_helper'
require 'generators/ember/route_generator'

class RouteGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::RouteGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "Assert files are properly created" do
    run_generator %w(index)

    assert_file "#{ember_path}/routes/index.js.es6"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "index", "-d", custom_path ]

    assert_file "#{custom_path}/routes/index.js.es6"
  end
end

