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
      client_already_exists
    elsif client.save
      client_successfully_created
    else
      parameters_missing
    end
  end

  def client_already_exists
    @status = 403
    @body   = "Client with identifier: \"#{client.identifier}\" already exists!"
  end

  def client_successfully_created
    @status = 200
    @body   = "{\"identifier\":\"#{client.identifier}\"}"
  end

  def parameters_missing
    @status = 400
    @body   = "#{client.errors.full_messages.join(", ")}"
  end
end
