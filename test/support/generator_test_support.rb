require 'pathname'

module GeneratorTestSupport
  # def run_generator(args=self.default_arguments, config={})
    # args += ['--skip-bundle'] unless args.include? '--dev'
    # self.generator_class.start(args, config.reverse_merge(destination_root: destination_root))
  # end

  def prepare_destination
    super

    tmp_destination = Pathname.new(destination_root)
    javascript_destination = tmp_destination.join('app','assets','javascripts')

    FileUtils.mkdir_p javascript_destination
    FileUtils.cp "test/fixtures/rails_4-0-0_application.js", javascript_destination.join('application.js')

    FileUtils.mkdir_p tmp_destination.join(app_path)
    FileUtils.mkdir_p tmp_destination.join(config_path)

    FileUtils.mkdir_p javascript_destination.join('custom')
    FileUtils.cp "test/fixtures/rails_4-0-0_application.js", javascript_destination.join('custom', 'application.js')

    FileUtils.cp 'test/fixtures/rails_4-0-0_Gemfile', tmp_destination.join('Gemfile')

    FileUtils.mkdir_p tmp_destination.join('app','views', 'layouts')
    FileUtils.cp 'test/fixtures/rails_4-0-0_application_layout', tmp_destination.join('app','views','layouts', 'application.html.erb')
  end

  def with_config(options = {})
    original_values = ::Rails.configuration.ember.appkit.clone
    original_values.paths = original_values.paths.clone
    original_values.paths.app = original_values.paths.app.clone
    original_values.paths.config = original_values.paths.config.clone

    options.each do |key, value|
      if Hash === value
        value.each do |k, v|
          ::Rails.configuration.ember.appkit[key][k] = v
        end
      else
        ::Rails.configuration.ember.appkit[key] = value
      end
    end

    yield
  ensure
    ::Rails.configuration.ember.appkit.clear
    ::Rails.configuration.ember.appkit = original_values
  end

  def assert_new_dirs(options = {})
    path = options[:in_path] || app_path

    %W{components templates templates/components routes}.each do |dir|
      assert_directory "#{path}/#{dir}"
      assert_file "#{path}/#{dir}/.gitkeep"
    end
  end

  def application_name
    "App"
  end

  def app_path(path = 'app')
    path 
  end

  def config_path(path = 'config')
    path
  end

  def copy_router(path = config_path)
    source = File.expand_path("../../../lib/generators/templates/router.js.es6", __FILE__)
    destination = File.join(destination_root, path)
    FileUtils.mkdir_p(destination)
    FileUtils.cp source, File.join(destination, 'router.js.es6')
  end

  def copy_application(path = config_path)
    source = File.expand_path("../../dummy/config/application.rb", __FILE__)
    destination = File.join(destination_root, path)
    FileUtils.mkdir_p(destination)
    copy_file source, File.join(destination, 'application.rb')
  end
end
