require 'pathname'

module GeneratorTestSupport
  def prepare_destination
    super

    tmp_destination = Pathname.new(destination_root)
    javascript_destination = tmp_destination.join('app','assets','javascripts')

    FileUtils.mkdir_p javascript_destination
    FileUtils.cp "test/fixtures/rails_4-0-0_application.js", javascript_destination.join('application.js')

    FileUtils.mkdir_p javascript_destination.join('custom')
    FileUtils.cp "test/fixtures/rails_4-0-0_application.js", javascript_destination.join('custom', 'application.js')

    FileUtils.cp 'test/fixtures/rails_4-0-0_Gemfile', tmp_destination.join('Gemfile')

    FileUtils.mkdir_p tmp_destination.join('app','views', 'layouts')
    FileUtils.cp 'test/fixtures/rails_4-0-0_application_layout', tmp_destination.join('app','views','layouts', 'application.html.erb')
  end

  def with_config(options = {})
    original_values = ::Rails.configuration.ember.to_h

    options.each do |(key, value)|
      ::Rails.configuration.ember[key] = value
    end

    yield
  ensure
    ::Rails.configuration.ember.clear
    original_values.each do |(key, value)|
      ::Rails.configuration.ember[key] = value
    end
  end

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

  def copy_routes
    routes = File.expand_path("../../dummy/config/routes.rb", __FILE__)
    destination = File.expand_path('../../dummy/tmp/config', __FILE__)
    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, destination
  end
end
