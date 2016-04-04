require_relative '../test_helper'

class UserCanViewIndexOfEvents < Minitest::Test
  include TestHelper
  include Capybara::DSL

  def test_user_sees_error_page_with_invalid_url
    visit '/notarealpage'

    assert page.has_content?("Something went wrong!")

    within(".bork") do
      assert page.has_content?("Page not found - bork bork bork!")
    end
  end
end
