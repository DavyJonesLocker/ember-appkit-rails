require 'sprockets/processed_asset'

module Ember::Appkit::Rails::Sprockets::ProcessedAsset
  def initialize(environment, logical_path, pathname)
    super

    _make_ember_application_template_stale(pathname)
  end

  def init_with(environment, coder)
    super

    _make_ember_application_template_stale(coder['pathname'])
  end

  private

  def _make_ember_application_template_stale(pathname)
    if pathname.to_s =~ /ember-appkit-rails.+\/app\/assets\/javascripts\/templates\/application.hbs/
      def self.fresh?(environment)
        false
      end
    end
  end
end

Sprockets::ProcessedAsset.send(:prepend, Ember::Appkit::Rails::Sprockets::ProcessedAsset)
