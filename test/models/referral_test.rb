require_relative '../test_helper'

class ReferralTest < Minitest::Test
  include TestHelper

  def test_it_can_save_a_referral
    Referral.create(root_url: "http://jumpstartlabs.com",
                        path: "/example")

    referral = Referral.first

    assert_equal "http://jumpstartlabs.com", referral.root_url
    assert_equal "/example", referral.path
  end

  def test_it_doesnt_save_referral_with_invalid_root_url
    Referral.create(path: "/example")

    assert_equal [], Referral.all.to_a
  end

  def test_it_doesnt_save_referral_with_invalid_path
    Referral.create(root_url: "/example")

    assert_equal [], Referral.all.to_a
  end

  def test_it_has_many_payload_requests
    referral = create_referral

    create_generic_payload_requests

    assert_equal 2, referral.payload_requests.count
  end

  def test_it_can_return_the_full_path
    Referral.create(root_url: "http://jumpstartlabs.com",
                        path: "/example")

    referral = Referral.first

    assert_equal "http://jumpstartlabs.com/example", referral.full_path
  end
end
