module Locomotive::Coal

  class ClientV2 < Client

    private

    def uri_path(handle = nil)
      "#{self.options[:path_prefix]}/api"
    end

    def uri_for_site(site)
      site.domains.first
    end

  end

end
