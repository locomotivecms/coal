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

  class MissingURIOrCredentialsError < Error; end
  class UnknownResourceError < Error; end
  class TooManyRequestsError < Error; end
  class UnauthorizedError < Error; end
  class BadRequestError < Error; end
  class ServerSideError < Error; end
  class TimeoutError < Error; end

  class InvalidResourceError < Error

    private

    def build_message
      attributes = body['attributes'].map do |name, errors|
        "#{name} #{errors.join(' ')}"
      end
      "#{body['error']}: #{attributes.join(', ')}"
    end
  end

end
