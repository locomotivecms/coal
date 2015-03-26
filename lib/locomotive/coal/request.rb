module Locomotive::Coal

  module Request

    def get(endpoint, parameters = {}, raw = false)
      safe_request_call(raw) do
        Unirest.get   "#{uri.to_s}/#{endpoint}.json",
          headers:    { 'Accept' => 'application/json' },
          auth:       uri.userinfo,
          parameters: parameters.merge(auth_token: token)
      end
    end

    def post(endpoint, parameters = {})
      parameters = parameters.merge(auth_token: token) if respond_to?(:token)

      safe_request_call do
        Unirest.post  "#{uri.to_s}/#{endpoint}.json",
          auth:       uri.userinfo,
          headers:    { 'Accept' => 'application/json' },
          parameters: parameters
      end
    end

    def put(endpoint, parameters = {})
      parameters = parameters.merge(auth_token: token) if respond_to?(:token)

      safe_request_call do
        Unirest.put   "#{uri.to_s}/#{endpoint}.json",
          auth:       uri.userinfo,
          headers:    { 'Accept' => 'application/json' },
          parameters: parameters
      end
    end

    def delete(endpoint, id)
      safe_request_call do
        Unirest.delete    "#{uri.to_s}/#{endpoint}/#{id}.json",
          auth:           uri.userinfo,
          headers:        { 'Accept' => 'application/json' },
          parameters:     { auth_token: token }
      end
    end

    private

    def safe_request_call(raw = false, &block)
      response = begin
        yield
      rescue Exception => e
        raise Locomotive::Coal::BadRequestError.new(e)
      end

      if response.code == 200
        raw ? response : response.body
      else
        raise Locomotive::Coal::Error.from_response(response)
      end
    end

  end

end
