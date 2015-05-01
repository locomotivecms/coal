module Locomotive::Coal
  module Resources

    class ContentTypes < Base

      def by_slug(slug)
        get('content_types').each do |attributes|
          return Resource.new(attributes) if attributes['slug'] == slug.to_s
        end
        nil
      end

      def method_missing(meth, *args)
        if content_type = by_slug(meth)
          Locomotive::Coal::Resources::ContentEntries.new(uri, credentials, content_type)
        else
          super
        end
      end

    end

  end
end
