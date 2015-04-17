module Locomotive::Coal

  module Resources

    class ContentEntries < Struct.new(:uri, :credentials, :content_type)

      include Concerns::Request

      def all(query = {}, options = {})
        parameters  = { where: query.to_json }.merge(options)
        response    = get(endpoint, parameters, true)

        list = response.body.map { |attributes| Resource.new(attributes) }

        PaginatedResources.new(list,
          options[:page] || 1,
          response.headers[:x_total_pages].to_i,
          response.headers[:x_total_entries].to_i)
      end

      def update(id, attributes)
        data = put(endpoint + "/#{id}", { content_entry: attributes })
        Resource.new(data)
      end

      private

      def endpoint
        "content_types/#{content_type.slug}/entries"
      end

    end

  end
end
