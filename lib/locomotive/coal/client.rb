module Locomotive::Coal

  class Client

    attr_reader :uri, :credentials, :options

    attr_accessor :scoped_by_site

    def initialize(uri, credentials, options = {})
      if uri.blank? || credentials.blank?
        raise MissingURIOrCredentialsError.new('URI and/or credentials are missing')
      else
        @options = { path_prefix: 'locomotive' }
        @uri, @credentials = prepare_uri(uri), credentials
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
        new_uri = uri_for_site(site)

        self.class.new(new_uri, credentials, options).tap do |_client|
          _client.scoped_by_site = true
        end
      end
    end

    def reset
      @token = nil
    end

    def ssl?
      !!self.options[:ssl]
    end

    private

    def credentials_with_token
      credentials.merge(token: -> { token })
    end

    def uri_for_site(site)
      (new_uri = self.uri.dup).path = ''
      new_uri = prepare_uri(new_uri, site.handle)
    end

    def uri_path(handle = nil)
      [self.options[:path_prefix], handle, 'api', 'v3'].compact.join('/')
    end

    def prepare_uri(uri, handle = nil)
      URI(uri).tap do |uri|
        uri.scheme = 'https' if ssl?

        if uri.path == '/' || uri.path == ''
          uri.merge!(uri_path(handle))
        end
      end
    end

    def domain
      self.uri.host
    end

  end

end
