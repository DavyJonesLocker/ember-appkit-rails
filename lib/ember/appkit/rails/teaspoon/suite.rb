module Ember::Appkit::Rails::Teaspoon::Suite
  def asset_from_file(filename)
    super.gsub(/(\.js\.es6|.es6)$/, '.js')
  end
end

Teaspoon::Suite.send(:prepend, Ember::Appkit::Rails::Teaspoon::Suite) if defined?(Teaspoon::Suite)
