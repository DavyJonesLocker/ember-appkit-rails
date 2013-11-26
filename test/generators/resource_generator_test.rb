require 'test_helper'
require 'generators/ember/resource_generator'

class ResourceGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ResourceGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination, :copy_router

  test "create template" do
    run_generator ["post"]
    assert_file "appkit/templates/post.hbs"
  end

  test "create controller" do
    run_generator ["post"]
    assert_file "appkit/controllers/post.js.es6"
  end

  test "create route" do
    run_generator ["post"]
    assert_file "appkit/routes/post.js.es6"
    assert_file "appkit/router.js.es6" do |content|
      assert_match(%r{this.resource\('posts'\);}, content)
    end
  end

  test "skip route" do
    run_generator ["post", "--skip-route"]
    assert_no_file "appkit/routes/post.js.es6"
  end

  test "Uses config.ember.ember_path" do
    custom_path = ember_path("custom")
    copy_router(custom_path)

    with_config ember_path: custom_path do
      run_generator ["post"]
      assert_file "#{custom_path}/controllers/post.js.es6"
      assert_file "#{custom_path}/routes/post.js.es6"
    end
  end

  private

  def copy_router(custom_path = 'appkit')
    router = File.expand_path("../../../lib/generators/templates/router.js.es6", __FILE__)
    destination = File.expand_path("../../dummy/tmp/#{custom_path}", __FILE__)
    FileUtils.mkdir_p(destination)
    FileUtils.cp router, destination
  end
end
