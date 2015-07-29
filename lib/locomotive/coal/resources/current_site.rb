module Locomotive::Coal
  module Resources

    class CurrentSite < Struct.new(:uri, :credentials)

      include Concerns::Request

      def get(locale = nil)
        Resource.new(super('current_site', _locale: locale))
      end

      def update(attributes = {})
        data = put('current_site', site: attributes)
        Resource.new(data)
      end

      def destroy
        data = delete('current_site')
        Resource.new(data)
      end

    end

  end
end
