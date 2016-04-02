class UrlStatistics
  attr_reader :identifier,
              :relativepath,
              :url,
              :client,
              :view,
              :data

  def initialize(identifier, relativepath)
    @identifier   = identifier
    @relativepath = relativepath
    @client       = Client.find_by(identifier: identifier)
    @view         = render_url_stats_view
  end

  def render_url_stats_view
    if url_does_not_exist?
      :url_does_not_exist
    else
      @url = client.urls.find_by(path: relativepath)
      :show
    end
  end

  def url_does_not_exist?
    !@client.urls.exists?(path: relativepath)
  end

  def url_data
    {
      max_response_time:           url.max_response_time,
      min_response_time:           url.min_response_time,
      all_response_times:          url.all_response_times,
      average_response_times:      url.average_reponse_times.to_i,
      find_verbs:                  url.find_verbs,
      top_referrers:               url.top_referrers,
      top_user_agents:             url.top_user_agents,
    }
  end
end
