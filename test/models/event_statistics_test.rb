require_relative '../test_helper'

class EventStatisticsTest < Minitest::Test
  include TestHelper

  def test_it_returns_show_with_proper_identifier_and_event
    create_client
    create_payload_requests

    event      = EventStatistics.new("jumpstartlabs", "socialLogin")
    total_freq = 2

    assert_equal hour_freq, event.breakdown_by_hour
    assert_equal total_freq, event.total
  end

  def test_it_returns_error_page_invalid_event
    create_client
    create_payload_requests

    event = EventStatistics.new("jumpstartlabs", "neverHAPPENED")

    assert_equal :event_does_not_exist, event.view
  end

  def hour_freq
    { 0  => 0,
      1  => 0,
      2  => 0,
      3  => 0,
      4  => 0,
      5  => 0,
      6  => 0,
      7  => 0,
      8  => 0,
      9  => 0,
      10 => 0,
      11 => 0,
      12 => 1,
      13 => 0,
      14 => 0,
      15 => 0,
      16 => 0,
      17 => 0,
      18 => 0,
      19 => 0,
      20 => 0,
      21 => 1,
      22 => 0,
      23 => 0 }
  end

  def create_payload_requests
    event_1 = Event.create(name: "socialLogin")
    event_2 = Event.create(name: "startedRegistration")

    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event_1.id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: 2,
                    requested_at: "2013-02-16 20:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event_2.id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

    PayloadRequest.create(url_id: 1,
                    requested_at: "2013-02-16 12:38:28 -0700",
                   response_time: 1,
                     referral_id: 1,
                 request_type_id: 1,
                        event_id: event_1.id,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1,
                       client_id: 1)

  end

end
