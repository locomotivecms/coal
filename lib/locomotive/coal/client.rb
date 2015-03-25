module Locomotive::Coal

  class Client

    attr_reader :uri, :credentials

    def initialize(uri, credentials)
      if uri.blank? || credentials.blank?
        raise MissingURIOrCredentialsError.new('URI and/or credentials are missing')
      else
        @uri, @credentials = URI(uri), credentials
      end
    end

    def token
      @token ||= Resources::Token.new(uri, credentials).get
    end

    def my_account
      @my_account ||= Resources::MyAccount.new(uri, token).get
    end

  end

end
