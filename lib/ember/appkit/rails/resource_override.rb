require 'generators/ember/resource_override'

module Ember::Appkit::Rails::ResourceOverride
  def add_ember
    if options.ember
      super
    end
  end
end

Rails::Generators::ResourceGenerator.class_eval do
  prepend Ember::Appkit::Rails::ResourceOverride
  class_option :ember, aliases: '-e', desc: 'force ember resource to generate', optional: true, type: 'boolean', default: false, banner: '--ember'
end
