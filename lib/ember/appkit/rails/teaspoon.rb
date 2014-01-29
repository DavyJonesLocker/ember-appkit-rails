module Ember::Appkit::Rails::Teaspoon; end

if [:development, :test].include?(Rails.env.to_sym)
  require 'teaspoon'
  require 'ember/appkit/rails/teaspoon/suite'
end
