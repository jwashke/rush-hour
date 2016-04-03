require './test/test_helper'

class ViewClientDashboardTest < Minitest::Test
  include TestHelper
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def test_returns_success_post_valid_payload_request
    post '/sources', {identifier: 'jumpstartlab', rootUrl: 'http://jumpstartlab.com' }
    
    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
  end

end
