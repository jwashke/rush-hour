require_relative '../test_helper'

class UserCanViewStatisticsForSpecificUrls < Minitest::Test
  include TestHelper
  include Capybara::DSL

  def test_user_can_view_statistics_for_specific_url
    load_feature_test_data

    visit '/sources/jumpstartlabs/urls/apply'

    assert page.has_content?("Jumpstartlabs")
    assert page.has_content?("path: /apply")

    within(".response-times") do
      assert page.has_content?("Average")
      assert page.has_content?("Maximum")
      assert page.has_content?("Minimum")
      assert page.has_content?("10")
    end

    within(".all-response-times") do
      assert page.has_content?("All Response Times")
      assert page.has_content?("10")
      assert page.has_content?("1")
    end

    within(".http-verbs") do
      assert page.has_content?("HTTP Verbs Used")
      assert page.has_content?("Verb")
      assert page.has_content?("Times Used")
      assert page.has_content?("GET")
      assert page.has_content?("1")
    end

    within(".top-referrers") do
      assert page.has_content?("Top Three Referrers")
      assert page.has_content?("http://www.referral.com/")
      assert page.has_content?("1")
    end

    within(".popular-user-agents") do
      assert page.has_content?("Three Most Popular User Agents")
      assert page.has_content?("Chrome 24.0.1309")
      assert page.has_content?("Mac OS X 10.8.2")
      assert page.has_content?("1")
    end
  end
end
