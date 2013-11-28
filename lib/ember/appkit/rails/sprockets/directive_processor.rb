require 'sprockets/directive_processor'

module Ember::Appkit::Rails::Sprockets::DirectiveProcessor
  def process_require_environment_from_directive(path)
    context.require_asset(File.join(path, ::Rails.env))
  end
end

Sprockets::DirectiveProcessor.send(:include, Ember::Appkit::Rails::Sprockets::DirectiveProcessor)
