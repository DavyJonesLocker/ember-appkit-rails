require 'test_helper'
require 'generators/ember/route_generator'

class RouteGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::RouteGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "Assert files are properly created" do
    run_generator %w(index)

    assert_file "#{app_path}/routes/index.es6"
  end
end
