require 'test_helper'
require 'generators/ember/component_generator'

class ComponentGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ComponentGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "default_component" do
    run_generator ["PostChart"]
    assert_file "app/assets/javascripts/components/post-chart_component.js.es6"
    assert_file "app/assets/javascripts/templates/components/post-chart.hbs"
  end

  test "Assert files are properly created (CamelCase)" do
    run_generator %w(PostChart)
    assert_file "#{ember_path}/components/post-chart_component.js.es6"
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Assert object names are properly created with CamelCase name" do
    run_generator %w(PostChart)
    assert_file "#{ember_path}/components/post-chart_component.js.es6"
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Assert files are properly created (lower-case)" do
    run_generator %w(post-chart)
    assert_file "#{ember_path}/components/post-chart_component.js.es6"
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Assert object names are properly created with lower-case name" do
    run_generator %w(post-chart)
    assert_file "#{ember_path}/components/post-chart_component.js.es6"
    assert_file "#{ember_path}/templates/components/post-chart.hbs"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "PostChart", "-d", custom_path ]
    assert_file "#{custom_path}/components/post-chart_component.js.es6"
    assert_file "#{custom_path}/templates/components/post-chart.hbs"
  end

  test "Uses config.ember.ember_path" do
    custom_path = ember_path("custom")

    with_config ember_path: custom_path do
      run_generator ["PostChart"]
      assert_file "#{custom_path}/components/post-chart_component.js.es6"
      assert_file "#{custom_path}/templates/components/post-chart.hbs"
    end
  end
end
