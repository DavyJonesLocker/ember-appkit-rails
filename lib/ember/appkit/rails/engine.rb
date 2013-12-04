require 'ember-rails'

class Ember::Appkit::Rails::Engine < ::Rails::Engine
  config.ember.appkit = ActiveSupport::OrderedOptions.new
  config.ember.appkit.paths = ActiveSupport::OrderedOptions.new
  config.ember.appkit.namespaces = ActiveSupport::OrderedOptions.new
  config.ember.appkit.prefix_patterns = ActiveSupport::OrderedOptions.new

  config.ember.appkit.paths.app = 'app'
  config.ember.appkit.paths.config = 'config'
  config.ember.appkit.namespaces.app = 'app'
  config.ember.appkit.namespaces.config = 'config'

  config.ember.appkit.enable_logging = ::Rails.env.development?

  initializer :appkit_transpiler do
    config.ember.appkit.prefix_patterns.app ||= Regexp.new(File.join(::Rails.root, config.ember.appkit.namespaces.app))
    config.ember.appkit.prefix_patterns.config ||= Regexp.new(File.join(::Rails.root, config.ember.appkit.namespaces.config))

    ES6ModuleTranspiler.add_prefix_pattern config.ember.appkit.prefix_patterns.app, config.ember.appkit.namespaces.app
    ES6ModuleTranspiler.add_prefix_pattern config.ember.appkit.prefix_patterns.config, config.ember.appkit.namespaces.config
    ES6ModuleTranspiler.transform = lambda { |name| name.split('/').map { |n| n.underscore.dasherize }.join('/') }
  end

  initializer :appkit_handlebars do
    config.handlebars ||= ActiveSupport::OrderedOptions.new
    config.handlebars.output_type   = :amd
    config.handlebars.amd_namespace = config.ember.appkit.namespaces.app
  end

  initializer :appkit_router do |app|
    app.routes.append do
      get '/' => "landing#index"
    end
  end

  initializer :appkit_sprockets do
    assets = Sprockets::Railtie.config.assets

    assets_javascript = assets.paths.delete(::Rails.root.join('app','assets','javascripts').to_s)

    index_of_last_app_assets = assets.paths.rindex{|s| s.start_with?(::Rails.root.join('app').to_s) } + 1
    assets.paths.insert(index_of_last_app_assets, assets_javascript) if assets_javascript
    assets.paths.insert(index_of_last_app_assets, File.join(::Rails.root, config.ember.appkit.paths.config))
    assets.paths.insert(index_of_last_app_assets, File.join(::Rails.root, config.ember.appkit.paths.app))
  end
end
