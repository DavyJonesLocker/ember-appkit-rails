require 'test_helper'
require 'generators/ember/controller_generator'

class ControllerGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ControllerGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "array_controller" do
    run_generator ["post", "--array"]
    assert_file "#{app_path}/controllers/post.es6"
  end

  test "object_controller" do
    run_generator ["post", "--object"]
    assert_file "#{app_path}/controllers/post.es6"
  end

  test "default_controller" do
    run_generator ["post"]
    assert_file "#{app_path}/controllers/post.es6"
  end

  test "Assert files are properly created" do
    run_generator %w(ember)
    assert_file "#{app_path}/controllers/ember.es6"
  end

  test "Uses config.ember.appkit.paths.app" do
    custom_path = app_path("custom")

    with_config paths: {app: custom_path} do
      run_generator ["post", "--object"]
      assert_file "#{custom_path}/controllers/post.es6"
    end
  end
end
