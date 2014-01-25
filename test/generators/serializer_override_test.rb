require 'test_helper'

class SerializerOverrideTest < Rails::Generators::TestCase
  include GeneratorTestSupport

  tests Rails::Generators::SerializerGenerator
  destination File.join(Rails.root, "tmp")
  setup :prepare_destination

  test "create serializer under config/serializers" do
    run_generator ["post"]
    assert_file "#{config_path}/serializers/post_serializer.rb"
  end

  test "does not create serializer under app/serializers" do
    run_generator ["post"]
    assert_no_file "#{app_path}/serializers/post_serializer.rb"
  end
end
