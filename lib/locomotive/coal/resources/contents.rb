module Locomotive::Coal
  module Resources

    class Contents < Struct.new(:uri, :token)

      include Locomotive::Coal::Request

      def by_slug(slug)
        get('content_types').each do |attributes|
          return Resource.new(attributes) if attributes['slug'] == slug.to_s
        end
      end

      def method_missing(meth, *args)
        if content_type = by_slug(meth)
          Locomotive::Coal::Resources::ContentEntries.new(uri, token, content_type)
        else
          super
        end
      end

    end

  end
end
