require 'test_helper'
require 'generators/ember/scaffold_generator'

class ScaffoldGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::ScaffoldGenerator
  destination File.join(Rails.root, "tmp", "generator_test_output")
  setup :prepare_destination, :copy_router

  test "create template" do
    run_generator ["post", "published_at:date"]

    assert_files
    assert_test_files
    assert_inject_into_router
  end

  test "with namespaced name" do
    run_generator ["post/dog"]

    assert_namespaced_model_find
  end


  private

  def assert_files
    assert_file "#{app_path}/models/post.es6"
    assert_file "test/models/post_test.es6"

    assert_file "#{app_path}/routes/posts/edit.es6"
    assert_file "#{app_path}/routes/posts/index.es6"
    assert_file "#{app_path}/routes/posts/new.es6"
    assert_file "#{app_path}/routes/posts/show.es6"

    assert_file "#{app_path}/templates/posts.hbs"
    assert_file "#{app_path}/templates/posts/edit.hbs"
    assert_file "#{app_path}/templates/posts/form.hbs" do |content|
      assert_match(/value=publishedAt/, content)
    end
    assert_file "#{app_path}/templates/posts/index.hbs" do |content|
      assert_match(/{{publishedAt}}/, content)
    end
    assert_file "#{app_path}/templates/posts/new.hbs"
    assert_file "#{app_path}/templates/posts/show.hbs" do |content|
      assert_match(/{{publishedAt}}/, content)
    end
  end

  def assert_inject_into_router
    js = <<-JS
  this.resource('posts', function() {
    this.route('new');
    this.route('show', {path: ':post_id'});
    this.route('edit', {path: ':post_id/edit'});
  });
JS
    assert_file "#{config_path}/router.es6" do |content|
      assert_match(/#{Regexp.escape(js.rstrip)}/m, content)
    end
  end

  def assert_namespaced_model_find
    assert_file "#{app_path}/routes/dogs/edit.es6" do |content|
      assert_match(/return this\.store\.find\('post\/dog', params.dog_id\);/, content)
    end
    assert_file "#{app_path}/routes/dogs/index.es6" do |content|
      assert_match(/return this\.store\.find\('post\/dog'\);/, content)
    end
    assert_file "#{app_path}/routes/dogs/new.es6" do |content|
      assert_match(/return this\.store\.createRecord\('post\/dog'\);/, content)
    end
    assert_file "#{app_path}/routes/dogs/show.es6" do |content|
      assert_match(/return this\.store\.find\('post\/dog', params.dog_id\);/, content)
    end
  end

  def assert_test_files
    assert_file "test/routes/posts/edit_test.es6" do |content|
      assert_match(/^import PostsEditRoute from 'app\/routes\/posts\/edit';/, content)
      assert_match(/'Unit - PostsEditRoute'/, content)
    end
    assert_file "test/routes/posts/index_test.es6" do |content|
      assert_match(/^import PostsIndexRoute from 'app\/routes\/posts\/index';/, content)
      assert_match(/'Unit - PostsIndexRoute'/, content)
    end
    assert_file "test/routes/posts/new_test.es6" do |content|
      assert_match(/^import PostsNewRoute from 'app\/routes\/posts\/new';/, content)
      assert_match(/'Unit - PostsNewRoute'/, content)
    end
    assert_file "test/routes/posts/show_test.es6" do |content|
      assert_match(/^import PostsShowRoute from 'app\/routes\/posts\/show';/, content)
      assert_match(/'Unit - PostsShowRoute'/, content)
    end

    assert_file "test/controllers/posts/edit_test.es6" do |content|
      assert_match(/^import PostsEditController from 'app\/controllers\/posts\/edit';/, content)
      assert_match(/'Unit - PostsEditController'/, content)
    end
    assert_file "test/controllers/posts/index_test.es6" do |content|
      assert_match(/^import PostsIndexController from 'app\/controllers\/posts\/index';/, content)
      assert_match(/'Unit - PostsIndexController'/, content)
    end
    assert_file "test/controllers/posts/new_test.es6" do |content|
      assert_match(/^import PostsNewController from 'app\/controllers\/posts\/new';/, content)
      assert_match(/'Unit - PostsNewController'/, content)
    end
    assert_file "test/controllers/posts/show_test.es6" do |content|
      assert_match(/^import PostsShowController from 'app\/controllers\/posts\/show';/, content)
      assert_match(/'Unit - PostsShowController'/, content)
    end
  end
end
