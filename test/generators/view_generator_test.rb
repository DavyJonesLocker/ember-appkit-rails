require 'test_helper'
require 'generators/ember/view_generator'

class ViewGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ViewGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "create view with template by default" do
    run_generator ["post"]
    assert_file "#{ember_path}/views/post.js.es6"
    assert_file "#{ember_path}/templates/post.hbs"
  end

  test "create view without a template" do
    run_generator ["post", "--without-template"]
    assert_file "#{ember_path}/views/post.js.es6"
    assert_no_file "#{ember_path}/templates/post.hbs"
  end

  test "create view and template (using ember-rails flags)" do
    run_generator ["post", "--with-template"]
    assert_file "#{ember_path}/views/post.js.es6"
    assert_file "#{ember_path}/templates/post.hbs"
  end

  test "create namespaced view" do
    run_generator ["post/index"]
    assert_file "#{ember_path}/views/post/index.js.es6"
  end

  test "Assert files are properly created" do
    run_generator %w(ember)
    assert_file "#{ember_path}/views/ember.js.es6"
  end

  test "Assert files are properly created with custom path" do
    custom_path = ember_path("custom")
    run_generator [ "ember", "-d", custom_path ]
    assert_file "#{custom_path}/views/ember.js.es6"
  end

  test "Uses config.ember.ember_path" do
    custom_path = ember_path("custom")

    with_config ember_path: custom_path do
      run_generator [ "ember"]
      assert_file "#{custom_path}/views/ember.js.es6"
    end
  end
end
