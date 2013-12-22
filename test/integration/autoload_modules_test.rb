require 'test_helper'

class AutoloadModulesTest < ActionDispatch::IntegrationTest
  include IntegrationTestSupport

  test 'does not auto create modules for directories that do not have ruby files' do
    FileUtils.mkdir(File.join(Rails.root, 'app/models/not_a_module'))

    assert_raise NameError do
      NotAModule
    end
  end

  test 'does create modules for directories that have ruby files' do
    FileUtils.mkdir(File.join(Rails.root, 'app/models/is_a_module'))
    FileUtils.touch(File.join(Rails.root, 'app/models/is_a_module/dog.rb'))

    assert_nothing_raised NameError do
      IsAModule
    end
  end
end
