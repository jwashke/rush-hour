class UrlStatistics
  attr_reader :path,
              :client,
              :view,
              :data,
              :url

  def initialize(identifier, path)
    @path         = "/" + path
    @client       = Client.find_by(identifier: identifier)
    @view         = get_url_view
  end

  def get_url_view
    @url = client.urls.find_by(path: path)

    if url_exists?
      @data = url_data
      :show_url_statistics
    else
      :url_does_not_exist
    end
  end

  def url_exists?
    client.urls.exists?(path: path)
  end

  def url_data
    {
      max_response_time:           url.max_response_time,
      min_response_time:           url.min_response_time,
      all_response_times:          url.all_response_times,
      average_response_times:      url.average_response_time.to_i,
      find_verbs:                  url.find_verbs,
      top_referrers:               url.top_referrers,
      top_user_agents:             url.top_user_agents,
    }
  end
end
