module RushHour
  class Server < Sinatra::Base

    not_found do
      data = "Page not found"
      erb :error, locals: { data: data }
    end

    get '/' do
      clients = Client.all
      erb :index, locals: { clients: clients }
    end

    post '/sources' do
      client_creator = ClientCreator.new(params)
      client_creator.create_client
      status client_creator.status
      body client_creator.body
    end

    post '/sources/:id/data' do |id|
      parser = PayloadParser.new
      parser.send_request(params)
      status parser.status
      body parser.body
    end

    get '/sources/:identifier' do |identifier|
      client_stats = ClientStatistics.new(identifier)
      view         = client_stats.view
      data         = client_stats.data
      erb view, locals: { data: data,
                          identifier: identifier }
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      url_stats = UrlStatistics.new(identifier, relativepath)
      data      = url_stats.data
      view      = url_stats.view
      erb view, locals: { data:         data,
                          identifier:   identifier,
                          relativepath: relativepath }
    end

    get '/sources/:identifier/events/:eventname' do |identifier, eventname|
      event_stats = EventStatistics.new(identifier, eventname)
      view        = event_stats.view
      total       = event_stats.total
      data        = event_stats.data
      erb view, locals: { data:       data,
                          identifier: identifier,
                          eventname:  eventname,
                          total:      total }
    end

    get '/sources/:identifier/index/events' do |identifier|
      event_stats = EventStatistics.new(identifier, nil)
      view        = event_stats.get_all_events
      data        = event_stats.data
      erb view, locals: { identifier: identifier,
                          data:       data }
    end

  end
end
