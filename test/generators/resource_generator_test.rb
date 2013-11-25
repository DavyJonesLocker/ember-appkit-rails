require 'test_helper'
require 'generators/ember/resource_generator'

class ResourceGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ResourceGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination


  test "create template" do
    run_generator ["post"]
    assert_file "app/assets/javascripts/templates/post.hbs"
  end

  test "create controller" do
    run_generator ["post"]
    assert_file "app/assets/javascripts/controllers/post.js.es6"
  end

  test "create route" do
    run_generator ["post"]
    assert_file "app/assets/javascripts/routes/post.js.es6"
  end

  test "skip route" do
    run_generator ["post", "--skip-route"]
    assert_no_file "app/assets/javascripts/routes/post.js.es6"
  end

  test "Uses config.ember.ember_path" do
    custom_path = ember_path("custom")

    with_config ember_path: custom_path do
      run_generator ["post"]
      assert_file "#{custom_path}/controllers/post.js.es6"
      assert_file "#{custom_path}/routes/post.js.es6"
    end
  end
end
