module Locomotive::Coal

  module Request

    def get(endpoint, parameters = {}, raw = false)
      do_request :get, endpoint, parameters, raw
    end

    def post(endpoint, parameters = {}, raw = false)
      do_request :post, endpoint, parameters, raw
    end

    def put(endpoint, parameters = {}, raw = false)
      do_request :put, endpoint, parameters, raw
    end

    def delete(endpoint, parameters = {}, raw = false)
      do_request :delete, endpoint, parameters, raw
    end

    def do_request(action, endpoint, parameters = {}, raw = false)
      response = begin
        _do_request(action, "#{uri.to_s}/#{endpoint}.json", parameters)
      rescue Exception => e
        raise Locomotive::Coal::BadRequestError.new(e)
      end

      if response.code == 200
        raw ? response : response.body
      else
        raise Locomotive::Coal::Error.from_response(response)
      end
    end

    private

    def _do_request(action, url, parameters)
      parameters = parameters.merge(auth_token: token) if respond_to?(:token)

      Unirest.send(action,  url,
        auth:               uri.userinfo,
        headers:            { 'Accept' => 'application/json' },
        parameters:         parameters)
    end

  end

end
