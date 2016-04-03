require_relative '../test_helper'

class UserCanViewClientSources < Minitest::Test
  include TestHelper
  include Capybara::DSL

  def test_user_can_see_client_data
    load_feature_test_data

    visit '/sources/jumpstartlabs'

    assert page.has_content?("Jumpstartlabs")

    within(".response-times") do
      assert page.has_content?("Average")
      assert page.has_content?("Maximum")
      assert page.has_content?("Minimum")
      assert page.has_content?("10")
    end

    within(".request-types") do
      assert page.has_content?("GET")
    end

    within(".http-verbs") do
      assert page.has_content?("GET")
    end

    within(".urls") do
      assert page.has_content?("http://www.jumpstartlabs.com/")
    end

    within(".browser-os") do
      assert page.has_content?("Chrome 24.0.1309")
      assert page.has_content?("Mac OS X 10.8.2")
    end

    within(".resolution") do
      assert page.has_content?("1920 x 1080")
    end

    within(".other-sources") do
      assert page.has_content?("jumpstartlabs/apply")
    end
  end
end
