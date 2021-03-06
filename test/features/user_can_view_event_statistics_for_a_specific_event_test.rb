require_relative '../test_helper'

class UserCanViewStatisticsForSpecificEvents < Minitest::Test
  include TestHelper
  include Capybara::DSL

  def test_user_can_view_statistics_for_specific_event
    load_feature_test_data

    visit '/sources/jumpstartlabs/events/name'

    assert page.has_content?("Jumpstartlabs")
    assert page.has_content?("event: /name")

    within(".event-stats") do
      assert page.has_content?("Breakdown By Hour")
    end

    within(".success") do
      assert page.has_content?("Total Requests")
      assert page.has_content?("1")
    end
  end

  def test_user_sees_error_page_if_incorrect_client_identifier
    load_feature_test_data

    visit '/sources/jumpstartlabs/events/notname'

    assert page.has_content?("Something went wrong!")
    within(".bork") do
      assert page.has_content?("Event does not exist - bork bork bork!")
    end
  end
end
