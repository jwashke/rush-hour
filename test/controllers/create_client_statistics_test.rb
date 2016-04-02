require './test/test_helper'

class CreateClientStatisticsTest < Minitest::Test
  include TestHelper
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def payload_request
    "payload={\"url\":\"http://jumpstartlab.com/blog\",\"requestedAt\":\"2013-02-16 21:38:28 -0700\",\"respondedIn\":37,\"referredBy\":\"http://jumpstartlab.com/\",\"requestType\":\"GET\",\"parameters\":[],\"eventName\":\"socialLogin\",\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17\",\"resolutionWidth\":\"1920\",\"resolutionHeight\":\"1280\",\"ip\":\"63.29.38.211\"}"
  end

  def test_it_returns_show_page_for_valid_client
    create_client
    post '/sources/jumpstartlabs/data', payload_request

    get '/sources/jumpstartlabs'

    assert last_response.body.include?("Jumpstartlabs")
  end

  def test_it_returns_show_page_for_invalid_client
    get '/sources/notvalidindustries'

    assert last_response.body.include?("Client does not exist")
  end

  def test_it_returns_show_page_for_invalid_client
    create_client
    get '/sources/jumpstartlabs'

    assert last_response.body.include?("Client has no requests")
  end

end
