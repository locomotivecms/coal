require 'json'

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
          raw ? response : _parse_response_body(response.body)
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

      def _parse_response_body response_body
        if response_body.is_a? String
          response_body = JSON.parse(response_body)
        end
        response_body
      end

      def _do_request(action, endpoint, parameters)
        # compatibility with v2.5.x
        parameters = parameters.merge(auth_token: credentials[:token]) if _token

        _connection.send(action, endpoint) do |request|
          request.headers.merge!(_request_headers(parameters))

          if %i(post put).include?(action)
            request.body = _encode_parameters(parameters)
          else
            request.params = parameters
          end
        end
      end

      def _request_headers(parameters)
        { 'Accept' => 'application/json' }.tap do |headers|
          if _token
            headers['X-Locomotive-Account-Email'] = credentials[:email]
            headers['X-Locomotive-Account-Token'] = credentials[:token]
            headers['X-Locomotive-Site-Handle']   = credentials[:handle] if credentials[:handle].present?
          end

          headers['X-Locomotive-Locale'] = parameters.delete(:_locale).to_s if parameters.try(:has_key?, :_locale)
        end
      end

      def _connection
        @_connection ||= Faraday.new(url: "#{uri.scheme}://#{uri.host}:#{uri.port}") do |faraday|
          faraday.request     :multipart
          faraday.request     :url_encoded             # form-encode POST params
          faraday.basic_auth  *uri.userinfo.split(':') if uri.userinfo

          faraday.use         FaradayMiddleware::ParseJson, content_type: /\bjson$/

          # ENV['no_proxy'] ignored in Faraday.default_adapter (Net::HTTP)
          faraday.adapter :httpclient
        end
      end

      def _token
        return if !!@without_token

        if credentials[:token].respond_to?(:call)
          credentials[:token] = credentials[:token].call
        end

        credentials[:token]
      end

      # https://github.com/ruby-grape/grape/issues/1028
      def _encode_parameters(parameters)
        return parameters unless parameters.is_a?(Hash)
        parameters.tap do
          parameters.each do |key, value|
            if value.is_a?(Array)
              parameters[key] = encode_array_to_hash(value) if value.first.is_a?(Hash)
            elsif value.is_a?(Hash)
              parameters[key] = _encode_parameters(value)
            end
          end
        end
      end

      # [{ name: 'a' }, { name: 'b' }] => { 0 => { name: 'a' }, 1 => { name: 'b' } }
      def encode_array_to_hash(value)
        {}.tap do |hash|
          value.each_with_index do |v, index|
            hash[index] = _encode_parameters(v)
          end
        end
      end

    end

  end
end
