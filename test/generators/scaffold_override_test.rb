require 'test_helper'

class ScaffoldOverrideTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Rails::Generators::ScaffoldGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination, :copy_routes, :reset_api_version

  test "create template without ember" do
    run_generator ["post"]
    assert_no_file "#{app_path}/templates/post.hbs"
  end

  test "create template with ember" do
    run_generator ["post", '--ember']
    assert_file "#{app_path}/templates/post.hbs"
  end

  test "does not create non-essential files for ember apps" do
    run_generator ["post", "title:string"]
    assert_no_file "#{app_path}/assets/javascripts/posts.js"
    assert_no_file "#{app_path}/helpers/posts_helper.rb"
    assert_no_directory "#{app_path}/views/posts"
  end

  test "creates properly namespaced api route" do
    run_generator ["post"]
    assert_file 'config/routes.rb' do |content|
      assert_match(/  namespace :api do\n    namespace :v1 do\n      resources :posts, except: \[:new, :edit\]\n    end\n  end/, content)
    end
  end

  test "creates properly namespaced api routes when api namespace already exists" do
    copy_routes_with_api_namespace
    run_generator ["post"]
    assert_file 'config/routes.rb' do |content|
      assert_match(/  namespace :api do\n    namespace :v1 do\n      resources :posts, except: \[:new, :edit\]\n    end\n  end/, content)
      assert_equal 1, content.scan(/api/).size
    end
  end

  test "creates properly namespaced api routes when api and version namespaces already exists" do
    copy_routes_with_api_and_version_namespaces
    run_generator ["post"]
    assert_file 'config/routes.rb' do |content|
      assert_match(/  namespace :api do\n    namespace :v1 do\n      resources :posts, except: \[:new, :edit\]\n    end\n  end/, content)
      assert_equal 1, content.scan(/api/).size
      assert_equal 1, content.scan(/v1/).size
    end
  end

  test "creates properly namespaced api routes when api and other version namespaces already exists" do
    copy_routes_with_api_and_version_namespaces
    ::Rails.application.config.ember.api_version = 2
    run_generator ["post"]
    assert_file 'config/routes.rb' do |content|
      assert_match(/  namespace :api do\n    namespace :v2 do\n      resources :posts, except: \[:new, :edit\]\n    end\n    namespace :v1 do\n    end\n  end/, content)
      assert_equal 1, content.scan(/api/).size
      assert_equal 1, content.scan(/v1/).size
      assert_equal 1, content.scan(/v2/).size
    end
  end

  private

  def reset_api_version
    ::Rails.application.config.ember.api_version = 1
  end

  def copy_routes
    copy_routes_file("../../dummy/config/routes.rb")
  end

  def copy_routes_with_api_namespace
    copy_routes_file("../../fixtures/routes_with_api_namespace.rb")
  end

  def copy_routes_with_api_and_version_namespaces
    copy_routes_file("../../fixtures/routes_with_api_and_version_namespaces.rb")
  end

  def copy_routes_file(routes_destination)
    routes = File.expand_path(routes_destination, __FILE__)
    destination = File.expand_path('../../dummy/tmp/config', __FILE__)
    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, File.join(destination, 'routes.rb')
  end
end
