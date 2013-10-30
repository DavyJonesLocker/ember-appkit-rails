require 'test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  tests Ember::Generators::BootstrapGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination

  def prepare_destination
    super

    dir = 'app/assets/javascripts'
    dest = Rails.root.join("tmp", "generator_test_output", dir)

    FileUtils.mkdir_p dest
    File.write(dest.join('application.js'), "")

    FileUtils.mkdir_p dest.join('custom')
    File.write(dest.join('custom/application.js'), "")
  end

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

  private

  def assert_new_dirs(options = {})
    path = options[:in_path] || ember_path

    %W{models controllers views helpers components templates templates/components routes}.each do |dir|
      assert_directory "#{path}/#{dir}"
      assert_file "#{path}/#{dir}/.gitkeep"
    end

  end

  def application_name
    "App"
  end

  def ember_path(custom_path = nil)
   "app/assets/javascripts/#{custom_path}".chomp('/')
  end
end
