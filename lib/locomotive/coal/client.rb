module Locomotive::Coal

  class Client

    attr_reader :uri, :credentials, :options

    def initialize(uri, credentials, options = {})
      if uri.blank? || credentials.blank?
        raise MissingURIOrCredentialsError.new('URI and/or credentials are missing')
      else
        @options = { path_prefix: 'locomotive' }.merge(options).with_indifferent_access
        @uri, @credentials = prepare_uri(uri), credentials.with_indifferent_access
      end
    end

    def token
      @token ||= Resources::Token.new(uri, credentials).get
    end

    def my_account
      @my_account ||= Resources::MyAccount.new(uri, connection)
    end

    def sites
      @sites ||= Resources::Sites.new(uri, connection)
    end

    def content_types
      @content_types ||= Resources::ContentTypes.new(uri, connection)
    end

    alias :contents :content_types

    def content_entries(content_type)
      @content_entries ||= {}
      @content_entries[content_type.slug] ||= Resources::ContentEntries.new(uri, connection, content_type)
    end

    def pages
      raise 'TODO'
    end

    def content_assets
      @content_assets ||= Resources::ContentAssets.new(uri, connection)
    end

    def theme_assets
      @theme_assets ||= Resources::ThemeAssets.new(uri, connection)
    end

    def snippets
      @snippets ||= Resources::Snippets.new(uri, connection)
    end

    def translations
      @translations ||= Resources::Translations.new(uri, connection)
    end

    def version
      raise 'TODO'
    end

    def scope_by(site)
      options[:handle] = site.handle
      self
    end

    def reset
      @token = @my_account = @sites = @content_types = @theme_assets = @content_assets = @translations = nil
    end

    def ssl?
      !!self.options[:ssl]
    end

    private

    def connection
      _token = credentials[:token] || -> { token }
      credentials.merge(token: _token, handle: options[:handle])
    end

    def uri_path
      [self.options[:path_prefix], 'api', 'v3'].join('/')
    end

    def prepare_uri(uri)
      uri = "http://#{uri.to_s}" unless uri.to_s =~ /^https?:\/\//

      URI(uri).tap do |uri|
        uri.scheme = 'https' if ssl?

        if uri.path == '/' || uri.path.blank?
          uri.merge!(uri_path)
        end
      end
    end

  end

end
