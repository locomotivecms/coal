module Locomotive::Coal

  module Request

    def get(endpoint, parameters = {})
      safe_request_call do
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

    private

    def safe_request_call(&block)
      response = begin
        yield
      rescue Exception => e
        raise Locomotive::Coal::BadRequestError.new(e)
      end

      if response.code == 200
        response.body
      else
        raise Locomotive::Coal::Error.from_response(response)
      end
    end

  end

end
