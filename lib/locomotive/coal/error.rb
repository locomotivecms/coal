module Locomotive::Coal

  # Take inspiration from this repository:
  # https://github.com/vigeland/hooty
  #
  class Error < StandardError

    def self.from_response(response)
      status = response.code
      if klass = case status
                  when 401      then Locomotive::Coal::UnauthorizedError
                  when 404      then Locomotive::Coal::UnknownResourceError
                  when 429      then Locomotive::Coal::TooManyRequestsError
                  when 400..499 then Error
                  end
        klass.new(response)
      end
    end
  end

  class MissingURIOrCredentialsError < Error; end
  class UnknownResourceError < Error; end
  class TooManyRequestsError < Error; end
  class UnauthorizedError < Error; end
  class BadRequestError < Error; end

end
