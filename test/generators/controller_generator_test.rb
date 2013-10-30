require 'test_helper'
require 'generators/ember/controller_generator'

class ControllerGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ControllerGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "array_controller" do
    run_generator ["post", "--array"]
    assert_file "app/assets/javascripts/controllers/post.js.es6"
  end

  test "object_controller" do
    run_generator ["post", "--object"]
    assert_file "app/assets/javascripts/controllers/post.js.es6"
  end

  test "default_controller" do
    run_generator ["post"]
    assert_file "app/assets/javascripts/controllers/post.js.es6"
  end

  test "default_controller namespaced" do
    run_generator ["post/index"]
    assert_file "#{ember_path}/controllers/post/index.js.es6", /PostIndexController/
  end

  test "Assert files are properly created" do
    run_generator %w(ember)
    assert_file "#{ember_path}/controllers/ember.js.es6"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "ember", "-d", custom_path ]
    assert_file "#{custom_path}/controllers/ember.js.es6"
  end
end
