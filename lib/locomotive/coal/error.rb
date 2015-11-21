module Locomotive::Coal

  # Take inspiration from this repository:
  # https://github.com/vigeland/hooty
  #
  class Error < StandardError

    attr_reader :response

    def initialize(response = nil)
      @response = response
      super(build_message)
    end

    def body
      @response.body || {}
    end

    def self.from_response(response)
      status = response.status
      if klass = case status.to_i
                  when 401      then Locomotive::Coal::UnauthorizedError
                  when 404      then Locomotive::Coal::UnknownResourceError
                  when 413      then Locomotive::Coal::FileTooBigError
                  when 422      then Locomotive::Coal::InvalidResourceError
                  when 429      then Locomotive::Coal::TooManyRequestsError
                  when 500      then Locomotive::Coal::ServerSideError
                  else Error
                  end
        klass.new(response)
      end
    end

    private

    def build_message
      @response ? body['error'] : nil
    end

  end

  class MissingURIOrCredentialsError < StandardError; end
  class BadRequestError < StandardError; end
  class UnknownResourceError < Error; end
  class TooManyRequestsError < Error; end
  class UnauthorizedError < Error; end
  class ServerSideError < Error; end
  class TimeoutError < Error; end


  class FileTooBigError < Error

    private

    def build_message
      'File too big for the server'
    end

  end

  class InvalidResourceError < Error

    private

    def build_message
      attributes = (body['attributes'] || body).map do |name, errors|
        if errors.is_a?(Hash)
          errors.map do |k, _errors|
            "#{name}.#{k}: #{_errors.join(' + ')}"
          end
        else
          "#{name} #{errors.join(' ')}"
        end
      end.join(', ')

      body['error'] ? "#{body['error']}: #{attributes}" : attributes
    end

  end

end
