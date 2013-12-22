require 'test_helper'

class AutoloadModulesTest < ActionDispatch::IntegrationTest
  include IntegrationTestSupport

  test 'does not auto create modules for directories that do not have ruby files' do
    assert_raise NameError do
      NotAModule
    end
  end

  test 'does create modules for directories that have ruby files' do
    assert_nothing_raised NameError do
      IsAModule
    end
  end
end
