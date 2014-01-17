class Ember::Appkit::Rails::Engine < ::Rails::Engine
  config.ember = ActiveSupport::OrderedOptions.new
  config.ember.paths = ActiveSupport::OrderedOptions.new
  config.ember.namespaces = ActiveSupport::OrderedOptions.new
  config.ember.prefix_patterns = ActiveSupport::OrderedOptions.new

  config.ember.paths.app = 'app'
  config.ember.paths.config = 'config'
  config.ember.namespaces.app = 'app'
  config.ember.namespaces.config = 'config'
  config.ember.api_version = 1

  generators do |app|
    app.config.generators.helper false
    app.config.generators.assets false
    app.config.generators.template_engine false

    ::Rails::Generators.configure!(app.config.generators)
    ::Rails::Generators.hidden_namespaces.uniq!
    require 'generators/ember/resource_override'
    require 'generators/ember/scaffold_override'
    require 'generators/ember/scaffold_controller_override'
  end

  initializer :appkit_transpiler do
    config.ember.prefix_patterns.app ||= Regexp.new(File.join(::Rails.root, config.ember.namespaces.app))
    config.ember.prefix_patterns.config ||= Regexp.new(File.join(::Rails.root, config.ember.namespaces.config))

    ES6ModuleTranspiler.add_prefix_pattern config.ember.prefix_patterns.app, config.ember.namespaces.app
    ES6ModuleTranspiler.add_prefix_pattern config.ember.prefix_patterns.config, config.ember.namespaces.config
    ES6ModuleTranspiler.transform = lambda { |name| name.split('/').map { |n| n.underscore.dasherize }.join('/') }
  end

  initializer :appkit_handlebars do
    config.handlebars = ActiveSupport::OrderedOptions.new

    config.handlebars.precompile = true
    config.handlebars.output_type = :global
    config.handlebars.templates_root = "templates"
    config.handlebars.templates_path_separator = '/'

    config.before_initialize do |app|
      Sprockets::Engines # force autoloading
      Sprockets.register_engine '.handlebars', Ember::Appkit::Rails::Template
      Sprockets.register_engine '.hbs', Ember::Appkit::Rails::Template
      Sprockets.register_engine '.hjs', Ember::Appkit::Rails::Template
    end

    config.handlebars ||= ActiveSupport::OrderedOptions.new
    config.handlebars.output_type   = :amd
    config.handlebars.amd_namespace = config.ember.namespaces.app
  end

  initializer :appkit_router do |app|
    app.routes.append do
      get '/' => "landing#index"
    end
  end

  initializer :appkit_sprockets do
    assets = Sprockets::Railtie.config.assets

    assets_javascript = assets.paths.delete(::Rails.root.join('app','assets','javascripts').to_s)
    assets.paths.delete(::Rails.root.join('lib', 'assets','javascript').to_s)

    index_of_last_app_assets = assets.paths.rindex { |path| path.to_s.start_with?(::Rails.root.join('app').to_s) } + 1
    assets.paths.insert(index_of_last_app_assets, File.join(::Rails.root, 'lib'))
    assets.paths.insert(index_of_last_app_assets, File.join(::Rails.root, config.ember.paths.app))
    assets.paths.insert(index_of_last_app_assets, File.join(::Rails.root, config.ember.paths.config))
  end

  initializer :appkit_setup_vendor, after: :append_assets_path, :group => :all do |app|
    app.config.assets.paths.append(File.dirname(::Ember::Source.bundled_path_for("ember.js")))
    app.config.assets.paths.append(File.dirname(::Ember::Data::Source.bundled_path_for("ember-data.js")))
    app.config.assets.paths.append(File.expand_path('../', ::Handlebars::Source.bundled_path))
  end
end
