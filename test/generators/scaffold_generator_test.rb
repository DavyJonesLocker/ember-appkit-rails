require 'test_helper'
require 'generators/ember/scaffold_generator'

class ScaffoldGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ScaffoldGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")
  setup :prepare_destination, :copy_router

  test "create template" do
    run_generator ["post"]

    assert_files
    assert_inject_into_router
  end

  private

  def assert_files
    assert_file "#{app_path}/models/post.js.es6"

    assert_file "#{app_path}/routes/posts/edit.js.es6"
    assert_file "#{app_path}/routes/posts/index.js.es6"
    assert_file "#{app_path}/routes/posts/new.js.es6"
    assert_file "#{app_path}/routes/posts/show.js.es6"

    assert_file "#{app_path}/templates/posts.hbs"
    assert_file "#{app_path}/templates/posts/edit.hbs"
    assert_file "#{app_path}/templates/posts/form.hbs"
    assert_file "#{app_path}/templates/posts/index.hbs"
    assert_file "#{app_path}/templates/posts/new.hbs"
    assert_file "#{app_path}/templates/posts/show.hbs"
  end

  def assert_inject_into_router
    js = <<-JS
  this.resource('posts', function() {
    this.route('new');
    this.route('show', {path: ':post_id'});
    this.route('edit', {path: ':post_id/edit'});
  });
JS
    assert_file "#{config_path}/router.js.es6" do |content|
      assert_match(/#{Regexp.escape(js.rstrip)}/m, content)
    end
  end
end
