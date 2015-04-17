module Locomotive::Coal::Resources
  module Concerns

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
          _do_request(action, "#{uri.path}/#{endpoint}.json", parameters)
        rescue ::Timeout::Error, ::Errno::ETIMEDOUT, Faraday::Error::TimeoutError => e
          raise Locomotive::Coal::TimeoutError.new(e)
        rescue Locomotive::Coal::Error
          raise
        rescue Exception => e
          raise Locomotive::Coal::BadRequestError.new(e)
        end

        if response.success?
          raw ? response : response.body
        else
          raise Locomotive::Coal::Error.from_response(response)
        end
      end

      def without_authentication(&block)
        @without_token = true
        yield.tap do
          @without_token = false
        end
      end

      private

      def _do_request(action, endpoint, parameters)
        # compatibility with v2.5.x
        parameters = parameters.merge(auth_token: credentials[:token]) if _token

        _connection.send(action, endpoint) do |request|
          request.headers = _request_headers
          request.params  = parameters
        end
      end

      def _request_headers
        { 'Accept' => 'application/json' }.tap do |headers|
          if _token
            headers['X-Locomotive-Account-Email'] = credentials[:email]
            headers['X-Locomotive-Account-Token'] = credentials[:token]
            headers['X-Locomotive-Site-Handle']   = credentials[:handle] if credentials[:handle].present?
          end
        end
      end

      def _connection
        @_connection ||= Faraday.new(url: "#{uri.scheme}://#{uri.host}:#{uri.port}") do |faraday|
          faraday.request     :url_encoded             # form-encode POST params
          faraday.basic_auth  uri.userinfo.values if uri.userinfo

          faraday.use         FaradayMiddleware::ParseJson, content_type: /\bjson$/

          faraday.adapter     Faraday.default_adapter  # make requests with Net::HTTP
        end
      end

      def _token
        return if !!@without_token

        if credentials[:token].respond_to?(:call)
          credentials[:token] = credentials[:token].call
        end

        credentials[:token]
      end

    end

  end
end
