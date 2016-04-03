require_relative '../test_helper'

class ClientStatisticsTest < Minitest::Test
  include TestHelper

  def test_it_returns_show_with_proper_client_and_payload
    create_client
    create_payload_requests

    client_stats = ClientStatistics.new("jumpstartlabs")

    assert_equal :show, client_stats.get_client_view
  end

  def test_it_returns_error_page_with_invalid_client
    create_payload_requests

    client_stats = ClientStatistics.new("jumpstartlabs")

    assert_equal :error, client_stats.get_client_view
  end

  def test_it_returns_error_page_with_invalid_client
    create_client

    client_stats = ClientStatistics.new("jumpstartlabs")

    assert_equal :error, client_stats.get_client_view
  end

  def create_payload_requests
    ua1 = UserAgent.create(browser: "Chrome 24.0.1309",
                           os: "Mac OS X 10.8.2")

    ua2 = UserAgent.create(browser: "IE 9.0",
                           os: "Mac OS X 10.8.2")

    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   100,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   ua1.id,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1, )
    PayloadRequest.create(
      url_id:          1,
      requested_at:    "2013-02-16 21:38:28 -0700",
      response_time:   300,
      referral_id:     1,
      request_type_id: 1,
      event_id:        1,
      user_agent_id:   ua2.id,
      resolution_id:   1,
      ip_id:           1,
      client_id:       1)
  end

end
