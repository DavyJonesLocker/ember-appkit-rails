module Ember::Appkit::Rails::Teaspoon::SpecController
  
end

ActiveSupport.on_load(:action_controller) do
  Teaspoon::SpecController.send(:prepend, Ember::Appkit::Rails::Teaspoon::SpecController) if defined?(Teaspoon::SpecController)
end