require 'test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::BootstrapGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "Assert folder layout and .gitkeep files are properly created" do
    run_generator []
    assert_new_dirs
  end

  test "create bootstrap" do
    run_generator []
    assert_file "#{ember_path}/ember-app.js.es6"
    assert_file "#{ember_path}/router.js.es6"
  end

  test "create bootstrap with and custom path" do
    custom_path = ember_path("custom")
    run_generator ["-d", custom_path]
    assert_file "#{custom_path}/ember-app.js.es6"
    assert_file "#{custom_path}/router.js.es6"
  end

  test "create bootstrap with custom app name" do
    run_generator ["-n", "MyApp"]
    assert_file "#{ember_path}/ember-app.js.es6", /MyApp = /
    assert_file "#{ember_path}/router.js.es6"
  end
end
