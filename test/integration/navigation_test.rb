require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'can render home page' do
    assert page.has_content 'Brian Cardarella'
  end
end

