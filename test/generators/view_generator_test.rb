require 'test_helper'
require 'generators/ember/view_generator'

class ViewGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ViewGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  test "create view with template by default" do
    run_generator ["post"]
    assert_file "#{app_path}/views/post.es6"
    assert_file "#{app_path}/templates/post.hbs"
  end

  test "create view without a template" do
    run_generator ["post", "--without-template"]
    assert_file "#{app_path}/views/post.es6"
    assert_no_file "#{app_path}/templates/post.hbs"
  end

  test "create view and template (using ember-rails flags)" do
    run_generator ["post", "--with-template"]
    assert_file "#{app_path}/views/post.es6"
    assert_file "#{app_path}/templates/post.hbs"
  end

  test "create namespaced view" do
    run_generator ["post/index"]
    assert_file "#{app_path}/views/post/index.es6"
  end

  test "Assert files are properly created" do
    run_generator %w(ember)
    assert_file "#{app_path}/views/ember.es6"
  end

  test "Uses config.ember.appkit.paths.app" do
    custom_path = app_path("custom")

    with_config paths: {app: custom_path} do
      run_generator [ "ember"]
      assert_file "#{custom_path}/views/ember.es6"
    end
  end
end
