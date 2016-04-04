require_relative '../test_helper'

class UserCanViewIndexOfEvents < Minitest::Test
  include TestHelper
  include Capybara::DSL

  def test_user_can_see_all_events
    load_feature_test_data

    visit '/sources/jumpstartlabs/index/events'

    assert page.has_content?("Jumpstartlabs Events Index")

    within(".events-index") do
      assert page.has_content?("jumpstartlabs/events/name")
      assert page.has_content?("All Events")
    end
  end

  def test_user_sees_error_page_with_bad_identifier
    visit '/sources/jumpstartlabs/index/events'

    assert page.has_content?("Something went wrong!")

    within(".bork") do
      assert page.has_content?("This client does not exist - bork bork bork!")
    end
  end
end
