require_relative '../test_helper'

class UserCanViewStatisticsForSpecificEvents < Minitest::Test
  include TestHelper
  include Capybara::DSL

  def test_user_can_view_statistiscs_for_specific_event
    load_feature_test_data

    visit '/sources/jumpstartlabs/events/name'
    
    assert page.has_content?("Jumpstartlabs")
    assert page.has_content?("name")
    save_and_open_page
    within(".event-stats") do
      assert page.has_content?("Breakdown By Hour")
      assert page.has_content?("All Events")
    end
  end
end
