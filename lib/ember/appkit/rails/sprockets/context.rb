require 'sprockets/context'

module Ember::Appkit::Rails::Sprockets::Context
  def asset_requirable?(path)
    return false if path.to_s.match File.join(::Rails.root, 'app/assets/javascripts')
    super
  end
end

Sprockets::Context.send(:prepend, Ember::Appkit::Rails::Sprockets::Context)
