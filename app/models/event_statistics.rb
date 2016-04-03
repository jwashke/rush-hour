class EventStatistics
  attr_reader :eventname,
              :client,
              :event,
              :pr,
              :data,
              :total

  def initialize(identifier, eventname)
    @client = Client.find_by(identifier: identifier)
    @event  = client.events.find_by(name: eventname)
    @pr     = PayloadRequest.where(event: event, client: client)
    view
  end

  def breakdown_by_hour
    # pr.group(:requested_at).count
    hour_freq = pr.each_with_object(Hash.new(0)) do |preq, hash|
      hash[Time.parse(preq.requested_at).hour] += 1
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
      :show
    end
  end

end
