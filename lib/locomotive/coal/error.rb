module Locomotive::Coal

  # Take inspiration from this repository:
  # https://github.com/vigeland/hooty
  #
  class Error < StandardError

    attr_reader :response

    def initialize(response)
      @response = response
      super
    end

    def errors
      @response.body
    end

    def self.from_response(response)
      status = response.status
      puts response.body
      if klass = case status
                  when 401      then Locomotive::Coal::UnauthorizedError
                  when 404      then Locomotive::Coal::UnknownResourceError
                  when 422      then Locomotive::Coal::InvalidResourceError
                  when 429      then Locomotive::Coal::TooManyRequestsError
                  when 400..499 then Error
                  when 500      then Locomotive::Coal::ServerSideError
                  end
        klass.new(response)
      end
    end

  end

  class InvalidResourceError < Error; end
  class MissingURIOrCredentialsError < Error; end
  class UnknownResourceError < Error; end
  class TooManyRequestsError < Error; end
  class UnauthorizedError < Error; end
  class BadRequestError < Error; end
  class ServerSideError < Error; end
  class TimeoutError < Error; end

end
