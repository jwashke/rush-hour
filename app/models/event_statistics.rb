class EventStatistics
  attr_reader :client,
              :event,
              :payload_requests,
              :data,
              :total

  def initialize(identifier, eventname)
    @client           = Client.find_by(identifier: identifier)
    @event            = client.events.find_by(name: eventname)
    @payload_requests = PayloadRequest.where(event: event, client: client)
  end

  def breakdown_by_hour
    payload_requests.map.with_object(initialize_hour_hash) do |request, hash|
      hash[Time.parse(request.requested_at).hour] += 1
    end
  end

  def event_does_not_exist?
    event.nil?
  end

  def view
    if event_does_not_exist?
      :event_does_not_exist
    else
      @data = breakdown_by_hour
      @total = event.number_of_times_received
        :event_statistics
    end
  end

  def initialize_hour_hash
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
      12 => 0,
      13 => 0,
      14 => 0,
      15 => 0,
      16 => 0,
      17 => 0,
      18 => 0,
      19 => 0,
      20 => 0,
      21 => 0,
      22 => 0,
      23 => 0 }
  end
end
