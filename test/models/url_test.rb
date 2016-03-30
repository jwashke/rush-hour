require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_url
    Url.create(root_url: "www.jumpstartlabs.com",
                   path: "/example")

    url = Url.first

    assert_equal "www.jumpstartlabs.com", url.root_url
    assert_equal "/example", url.path
  end

  def test_it_doesnt_save_url_with_invalid_path
    Url.create(root_url: "www.jumpstartlabs.com")

    assert_equal [], Url.all.to_a
  end

  def test_it_doesnt_save_url_with_invalid_root_url
    Url.create(path: "/example")

    assert_equal [], Url.all.to_a
  end

  def test_it_returns_the_full_path_url
    url = Url.create(root_url: "www.jumpstartlabs.com",
                   path: "/example")

    assert_equal "www.jumpstartlabs.com/example", url.full_path
  end

  def test_it_returns_the_maximum_response_time_for_a_specific_url
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)
    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal 200, Url.max_response_time("www.jumpstartlabs.com")
  end

  def test_it_returns_the_minimum_response_time_for_a_specific_url
    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: 1,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)
    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: 1,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal 100, Url.min_response_time("www.jumpstartlabs.com")
  end

  def test_it_returns_the_minimum_response_time_for_a_specific_url
    verb1 = RequestType.create(verb: "GET")
    verb2 = RequestType.create(verb: "POST")

    url1 = Url.create(root_url: "www.jumpstartlabs.com",
                          path: "/blog")

    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 100,
                     referral_id: 1,
                 request_type_id: verb1.id,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)
    PayloadRequest.create(url_id: url1.id,
                    requested_at: "2013-02-16 21:38:28 -0700",
                   response_time: 200,
                     referral_id: 1,
                 request_type_id: verb2.id,
                   event_id: 1,
                   user_agent_id: 1,
                   resolution_id: 1,
                           ip_id: 1)

    assert_equal 100, Url.find_verbs_for_a_url("www.jumpstartlabs.com")
  end


end
