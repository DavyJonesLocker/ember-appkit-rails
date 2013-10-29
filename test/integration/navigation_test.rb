require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'can render home page' do
    visit root_path
    assert page.has_text? 'Joe Doe'
  end
end

