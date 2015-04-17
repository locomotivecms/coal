module Locomotive::Coal
  module Resources

    class Sites < Base

      # Only v2.x
      def by_subdomain(subdomain)
        all.find { |site| site.subdomain == subdomain.to_s }
      end

      # Only >= v3
      def by_handle(handle)
        all.find { |site| site.handle == handle.to_s }
      end

    end

  end
end
