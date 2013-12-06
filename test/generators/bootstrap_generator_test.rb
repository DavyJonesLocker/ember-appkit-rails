require 'test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::BootstrapGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination, :copy_application

  test "Assert folder layout and .gitkeep files are properly created" do
    run_generator []
    assert_new_dirs
  end

  test "create bootstrap" do
    run_generator []

    assert_files
  end

  test "create bootstrap with and custom app path" do
    custom_path = app_path("custom")
    run_generator ["-a", custom_path]

    assert_files custom_path, config_path
    assert_file 'config/application.rb', /config\.ember\.appkit\.paths\.app = '#{custom_path}'/
  end

  test "create bootstrap with and custom config path" do
    custom_path = config_path("custom")
    run_generator ["-c", custom_path]

    assert_files app_path, custom_path
    assert_file 'config/application.rb', /config\.ember\.appkit\.paths\.config = '#{custom_path}'/
  end

  test "create bootstrap with custom app name" do
    run_generator ["-n", "MyApp"]

    assert_file "#{config_path}/application.js", /MyApp = /

    assert_files
  end

  test "Uses config.ember.app_name" do
    with_config app_name: 'Blazorz' do
      run_generator

      assert_files
      assert_file "#{config_path}/application.js", /Blazorz = /
    end
  end

  test "Uses config.ember.appkit.paths.app" do
    custom_app_path = app_path("custom_app")
    custom_config_path = app_path("custom_config")

    with_config paths: {app: custom_app_path, config: custom_config_path}  do
      run_generator

      assert_files custom_app_path, custom_config_path
    end
  end

  test "Removes turbolinks" do
    run_generator

    confirm_turbolinks_removed "Gemfile"
    confirm_turbolinks_removed "app/views/layouts/application.html.erb"
  end

  test "Removed jbuilder" do
    run_generator

    assert_file 'Gemfile' do |content|
      assert_no_match(/jbuilder/, content)
    end
  end

  test "Removed app/assets/javascript directory" do
    run_generator
    assert_no_directory "app/assets/javascripts"
  end

  test "Does not error if Gemfile is missing" do
    FileUtils.rm destination_root + '/Gemfile'
    run_generator
  end

  private

  def assert_files(app_path = app_path, config_path = config_path)
    assert_file "#{config_path}/environment.js"
    assert_file "#{config_path}/environments/development.js"
    assert_file "#{config_path}/environments/production.js"
    assert_file "#{config_path}/environments/test.js"
    assert_file "#{config_path}/application.js"
    assert_file "#{config_path}/router.js.es6"
    assert_file "#{config_path}/adapter.js"
    assert_file "#{config_path}/initializers/csrf.js"
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
