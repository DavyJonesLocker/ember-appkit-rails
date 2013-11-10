require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'can render home page' do
    visit '/'
    assert page.has_text? 'Joe Doe'
  end
end

