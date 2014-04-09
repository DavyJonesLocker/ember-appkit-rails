require 'test_helper'
require 'generators/ember/bootstrap_generator'

class BootstrapGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::BootstrapGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")

  setup :prepare_destination, :copy_application, :copy_routes

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
    assert_file 'config/application.rb', /config\.ember\.paths\.app = '#{custom_path}'/
  end

  test "create bootstrap with and custom config path" do
    custom_path = config_path("custom")
    run_generator ["-c", custom_path]

    assert_files app_path, custom_path
    assert_file 'config/application.rb', /config\.ember\.paths\.config = '#{custom_path}'/
  end

  test "create bootstrap with custom app name" do
    run_generator ["-n", "MyApp"]

    assert_file "#{config_path}/application.js", /MyApp = /

    assert_files
  end

  test 'Creates bootstrap without Teaspoon' do
    run_generator ['-T']
    assert_no_file 'config/initializers/teaspoon.rb'
    assert_no_file 'test/teaspoon_env.rb'
    assert_no_file 'test/test_helper.js'
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

  test "Does not error if Gemfile is missing" do
    FileUtils.rm destination_root + '/Gemfile'
    run_generator
  end

  test "Adds commented out greedy matcher to Rails routes file" do
    run_generator

    assert_file 'config/routes.rb' do |content|
      assert_match(/^  # get '\*foo', :to => 'landing#index'$/, content)
    end
  end

  private

  def assert_files(app_path = app_path, config_path = config_path)
    %W{models controllers views routes components templates templates/components mixins}.each do |dir|
      assert_directory "#{app_path}/#{dir}"
    end
    assert_directory "#{config_path}/serializers"

    assert_file "#{config_path}/environment.js.erb"
    assert_file "#{config_path}/environments/development.js.erb"
    assert_file "#{config_path}/environments/production.js.erb"
    assert_file "#{config_path}/environments/test.js.erb"
    assert_file "#{config_path}/application.js"
    assert_file "#{config_path}/router.es6"
    assert_file "#{config_path}/adapters/application.es6.erb"
    assert_file "#{config_path}/initializers/csrf.js"
    assert_file "config/initializers/teaspoon.rb"
    assert_file "test/teaspoon_env.rb"
    assert_file "test/test_helper.js"
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
