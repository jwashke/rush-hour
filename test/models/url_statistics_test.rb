require_relative '../test_helper'

class UrlStatisticsTest < Minitest::Test
  include TestHelper

  def test_it_returns_show_with_a_proper_url
    create_client
    create_payload_requests

    stats_view = UrlStatistics.new("jumpstartlabs", "blog")

    assert_equal :show_url_statistics, stats_view.view
  end

  def test_it_returns_error_page_if_url_doesnt_exist
    create_client

    stats_view = UrlStatistics.new("jumpstartlabs", "blog")

    assert_equal :error, stats_view.view
  end

  def create_payload_requests
    url = Url.create(root_url: "www.jumpstartlabs.com",
                      path: "/blog")

    PayloadRequest.create(
      url_id:          url.id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   100,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1, )
    PayloadRequest.create(
      url_id:          url.id,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   300,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   1,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)
  end

end
