class Ember::Appkit::Rails::Teaspoon::Engine < ::Rails::Engine
  paths["app/views"] << Ember::Appkit::Rails::Engine.root.join('lib', 'ember', 'appkit', 'rails', 'views')
end
