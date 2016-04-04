class ClientCreator
  attr_reader :status,
              :body,
              :client

  def initialize(params)
    @client = Client.new(identifier: params[:identifier],
                         root_url:   params[:rootUrl])
  end

  def create_client
    if Client.exists?(identifier: client.identifier)
      @status = 403
    elsif client.save
      @status = 200
    else
      @status = 400
    end
    @body = status_body_map[status]
  end


  def status_body_map
    {
      200 => "{\"identifier\":\"#{client.identifier}\"}",
      400 => "#{client.errors.full_messages.join(", ")}",
      403 => "Client with identifier: \"#{client.identifier}\" already exists!"
    }
  end

end
