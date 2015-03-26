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
      @my_account ||= Resources::MyAccount.new(uri, token)
    end

    def sites
      @sites ||= Resources::Sites.new(uri, token)
    end

    def contents
      @contents ||= Resources::Contents.new(uri, token)
    end

    def scope_by(site)
      if site.domains.include?(domain)
        self
      else
        new_uri = site.domains.first
        self.class.new(new_uri, self.credentials).tap do |_client|
          _client.scoped_by_site = true
        end
      end
    end

    private

    def domain
      self.uri.to_s =~ /^https?:\/\/([^\/:]+)*/
      $1
    end

  end

end
