module Locomotive::Coal

  class Client

    attr_reader :uri, :credentials

    attr_accessor :scoped_by_site

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
      @my_account ||= Resources::MyAccount.new(uri, credentials_with_token)
    end

    def sites
      @sites ||= Resources::Sites.new(uri, credentials_with_token)
    end

    def contents
      @contents ||= Resources::Contents.new(uri, credentials_with_token)
    end

    def scope_by(site)
      if site.domains.include?(domain)
        self
      else
        new_uri = site.domains.first
        self.class.new(new_uri, credentials).tap do |_client|
          _client.scoped_by_site = true
        end
      end
    end

    def reset
      @token = nil
    end

    private

    def credentials_with_token
      credentials.merge(token: -> { token })
    end

    def domain
      # TODO: use self.uri.host instead
      self.uri.to_s =~ /^https?:\/\/([^\/:]+)*/
      $1
    end

  end

end
