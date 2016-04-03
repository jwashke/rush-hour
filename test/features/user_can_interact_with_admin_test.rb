require_relative '../test_helper'

class UserCanInteractWithAdmin < Minitest::Test
  include TestHelper
  include Capybara::DSL

  def test_user_can_see_all_clients
    create_client
    create_generic_payload_requests

    visit '/'

    assert page.has_content?("Admin View")

    within(".caption") do
      assert page.has_content?("Jumpstartlab")
      assert page.has_content?("All Events")
    end
  end
end
