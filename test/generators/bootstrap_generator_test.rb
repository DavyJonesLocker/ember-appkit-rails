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

    assert_files
  end

  test "create bootstrap with and custom path" do
    custom_path = ember_path("custom")
    run_generator ["-d", custom_path]

    assert_files custom_path
  end

  test "create bootstrap with custom app name" do
    run_generator ["-n", "MyApp"]

    assert_file "#{ember_path}/ember-app.js", /MyApp = /

    assert_files
  end

  test "Uses config.ember.app_name" do
    with_config app_name: 'Blazorz' do
      run_generator

      assert_files
      assert_file "#{ember_path}/ember-app.js", /Blazorz = /
    end
  end

  test "Uses config.ember.ember_path" do
    custom_path = ember_path("custom")

    with_config ember_path: custom_path do
      run_generator

      assert_files custom_path
    end
  end

  test "Removes turbolinks" do
    run_generator

    confirm_turbolinks_removed "Gemfile"
    confirm_turbolinks_removed "app/views/layouts/application.html.erb"
    confirm_turbolinks_removed "app/assets/javascripts/application.js"
  end

  test "Leaves turbolinks if --leave-turbolinks" do
    run_generator ['--leave-turbolinks']

    confirm_turbolinks_not_removed "Gemfile"
    confirm_turbolinks_not_removed "app/views/layouts/application.html.erb"
    confirm_turbolinks_not_removed "app/assets/javascripts/application.js"
  end

  test "Removes jquery-ujs" do
    run_generator

    assert_file 'app/assets/javascripts/application.js' do |content|
      assert_no_match /jquery_ujs/, content
    end
  end

  test "Leaves jquery-ujs if --leave-jqueryujs" do
    run_generator ['--leave-jqueryujs']


    assert_file 'app/assets/javascripts/application.js' do |content|
      assert_match /jquery_ujs/, content
    end
  end

  test "Does not error if Gemfile is missing" do
    FileUtils.rm destination_root + '/Gemfile'
    run_generator
  end

  private

  def assert_files(path = ember_path)
    assert_file "#{path}/ember-env.js"
    assert_file "#{path}/ember-app.js"
    assert_file "#{path}/router.js.es6"
    assert_file "#{path}/store.js"
  end

  def confirm_turbolinks_removed(file)
    assert_file file do |content|
      assert_no_match(/turbolinks/, content)
    end
  end

  def confirm_turbolinks_not_removed(file)
    assert_file file do |content|
      assert_match(/turbolinks/, content)
    end
  end
end
