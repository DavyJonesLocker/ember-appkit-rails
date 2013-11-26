class Ember::Appkit::Rails::Engine < ::Rails::Engine
  config.ember_appkit = ActiveSupport::OrderedOptions.new

  config.ember_appkit.namespace = 'appkit'
  config.ember_appkit.asset_path = config.ember_appkit.namespace
  config.ember_appkit.prefix_pattern = /^(controllers|models|views|helpers|routes|router|adapter)/

  config.ember_appkit.enable_logging = ::Rails.env.development?

  initializer "ember_appkit.configure" do
    ES6ModuleTranspiler.prefix_pattern = [config.ember_appkit.prefix_pattern, config.ember_appkit.namespace]

    config.handlebars ||= ActiveSupport::OrderedOptions.new
    config.handlebars.output_type   = :amd
    config.handlebars.amd_namespace = config.ember_appkit.namespace
  end

  initializer :add_builtin_route do |app|
    app.routes.append do
      get '/' => "landing#index"
    end
  end

  initializer :add_appkit_asset_path do
    Sprockets::Railtie.config.assets.paths.unshift(File.join(::Rails.root, config.ember_appkit.asset_path))
  end
end
