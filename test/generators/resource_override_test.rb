require 'test_helper'

class ResourceOverrideTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Rails::Generators::ResourceGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination, :copy_routes

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

  private

  def copy_routes
    routes = File.expand_path("../../dummy/config/routes.rb", __FILE__)
    destination = File.expand_path('../../dummy/tmp/config', __FILE__)
    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, destination
  end
end
