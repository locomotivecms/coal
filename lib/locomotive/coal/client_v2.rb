module Locomotive::Coal

  class ClientV2 < Client

    attr_accessor :scoped_by_site

    def scope_by(site)
      if site.domains.include?(domain)
        self
      else
        new_uri = site.domains.first

        self.class.new(new_uri, credentials, options).tap do |_client|
          _client.scoped_by_site = true
        end
      end
    end

    private

    def uri_path(handle = nil)
      "#{self.options[:path_prefix]}/api"
    end

    def domain
      self.uri.host
    end

  end

end
