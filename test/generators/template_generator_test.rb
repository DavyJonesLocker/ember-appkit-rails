require 'test_helper'
require 'generators/ember/template_generator'

class TemplateGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::TemplateGenerator
  destination File.join(Rails.root, "tmp")

  setup :prepare_destination

  test "generates template" do
    run_generator ["post"]
    assert_file "appkit/templates/post.hbs"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "post", "-d", custom_path ]
    assert_file "#{custom_path}/templates/post.hbs"
  end

  test "Uses config.ember.ember_path" do
    custom_path = ember_path("custom")

    with_config ember_path: custom_path do
      run_generator ["post"]
      assert_file "#{custom_path}/templates/post.hbs"
    end
  end
end
