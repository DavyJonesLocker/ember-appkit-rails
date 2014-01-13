require 'test_helper'

class EngineTest < ActionDispatch::IntegrationTest
  test 'app/assets/javascripts is not in asset load path' do
    refute Rails.application.config.assets.paths.include?(File.join(Rails.root, 'app/assets/javascripts'))
  end

  test 'app is in the asset load path' do
    assert Rails.application.config.assets.paths.include?(File.join(Rails.root, 'app'))
  end

  test 'config is in the asset load path' do
    assert Rails.application.config.assets.paths.include?(File.join(Rails.root, 'config'))
  end

  test 'lib is in the asset load path' do
    assert Rails.application.config.assets.paths.include?(File.join(Rails.root, 'lib'))
  end

  test 'lib/assets/javascripts is not in the asset load path' do
    refute Rails.application.config.assets.paths.include?(File.join(Rails.root, 'lib/assets/javascripts'))
  end

  test 'ember source assets come after vendor/assets/javascripts' do
    vendor_index = Rails.application.config.assets.paths.index(File.join(Rails.root, 'vendor/assets/javascripts'))
    ember_source_index = Rails.application.config.assets.paths.index { |path| path =~ /ember-source/ }
    ember_data_source_index = Rails.application.config.assets.paths.index { |path| path =~ /ember-data-source/ }
    handlebars_source_index = Rails.application.config.assets.paths.index { |path| path =~ /handlebars-source/ }

    assert vendor_index < ember_source_index
    assert vendor_index < ember_data_source_index
    assert vendor_index < handlebars_source_index
  end
end
