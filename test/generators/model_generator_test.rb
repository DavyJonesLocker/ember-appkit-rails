require 'test_helper'
require 'generators/ember/model_generator'

class ModelGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ModelGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "create model" do
    run_generator ["post", "title:string"]
    assert_file "#{app_path}/models/post.js.es6"
  end

  test "create namespaced model" do
    run_generator ["post/doineedthis", "title:string"]
    assert_file "#{app_path}/models/post/doineedthis.js.es6"
  end

  test "leave parentheses when create model w/o attributes" do
    run_generator ["post"]
    assert_file "#{app_path}/models/post.js.es6", /export default DS.Model.extend/
  end

  test "Assert files are properly created" do
    run_generator %w(ember)

    assert_file "#{app_path}/models/ember.js.es6"
  end

  test "Uses config.ember.appkit.paths.app" do
    custom_path = app_path("custom")

    with_config paths: {app: custom_path} do
      run_generator ["ember"]
      assert_file "#{custom_path}/models/ember.js.es6"
    end
  end
end
