require 'test_helper'

class ScaffoldOverrideTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Rails::Generators::ScaffoldGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination, :copy_routes, :copy_router, :reset_api_version

  test "create template without ember" do
    run_generator ["post"]
    assert_no_file "#{app_path}/templates/posts.hbs"
  end

  test "create template with ember" do
    run_generator ["post", 'title:string', '--ember']
    assert_file "#{app_path}/templates/posts.hbs"
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

  test "creates api version namespaced controller" do
    run_generator ["post"]
    assert_file 'app/controllers/api/v1/posts_controller.rb'
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

  test 'destroy does not remove any non-matching resources or namespaces' do
    copy_routes_with_api_version_namespaces_and_route
    config_content = File.read(File.expand_path('config/routes.rb', destination_root))
    run_generator ['post'], behavior: :revoke

    assert_file 'config/routes.rb' do |content|
      assert_equal config_content, content
    end
  end

  test 'destroy removes matching resources and namespaces' do
    copy_routes_with_api_version_namespaces_and_route
    config_content = File.read(File.expand_path('config/routes.rb', destination_root))
    run_generator ['dogs'], behavior: :revoke

    assert_file 'config/routes.rb' do |content|
      refute_match(/  namespace :api do\n    namespace :v1 do\n      resource :dogs, except: \[:new, :edit\]\n    end\n  end/, content)
    end
  end

  private

  def reset_api_version
    ::Rails.application.config.ember.api_version = 1
  end

  def copy_routes_with_api_namespace
    copy_routes_file("../../fixtures/routes_with_api_namespace.rb")
  end

  def copy_routes_with_api_and_version_namespaces
    copy_routes_file("../../fixtures/routes_with_api_and_version_namespaces.rb")
  end

  def copy_routes_with_api_version_namespaces_and_route
    copy_routes_file("../../fixtures/routes_with_api_version_namespaces_and_route.rb")
  end
end
