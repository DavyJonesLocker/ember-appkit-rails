require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  include IntegrationTestSupport

  test 'can render default landing page' do
    visit '/'
    assert page.has_text? "Welcome to Ember on Rails!"
  end

  test 'can using simple "ember magic"' do
    visit '/'
    fill_in 'sampleInput', with: 'EMBER ROCKS!'
    assert page.has_text? "EMBER ROCKS!"
  end
end
