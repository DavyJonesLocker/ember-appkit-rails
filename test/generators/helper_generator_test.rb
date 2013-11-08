require 'test_helper'
require 'generators/ember/helper_generator'

class HelperGeneratorTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Ember::Generators::HelperGenerator
  destination File.join(Rails.root, 'tmp')

  setup :prepare_destination

  test 'Generates helper correctly' do
    run_generator ['catdog']
    assert_file 'app/assets/javascripts/helpers/catdog.js', /catdog/
  end
end
