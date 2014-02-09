module Ember::Appkit::Rails::Teaspoon::SpecController
  def self.prepended(mod)
    mod.send(:before_filter, :extend_view_path)
  end

  def extend_view_path
    append_view_path Ember::Appkit::Rails::Engine.root.join('lib', 'ember', 'appkit', 'rails', 'views')
  end
end

ActiveSupport.on_load(:action_controller) do
  Teaspoon::SpecController.send(:prepend, Ember::Appkit::Rails::Teaspoon::SpecController)
end
