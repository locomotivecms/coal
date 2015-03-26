module Locomotive::Coal

  module Resources

    class ContentEntries < Struct.new(:uri, :token, :content_type)

      include Locomotive::Coal::Request

      def all(query = {}, options = {})
        parameters  = { where: query.to_json }.merge(options)
        response    = get(endpoint, parameters, true)

        list = response.body.map { |attributes| Resource.new(attributes) }

        PaginatedResources.new(list,
          response.headers[:x_total_pages].to_i,
          response.headers[:x_total_entries].to_i)
      end

      def update(id, attributes)
        data = put(endpoint + "/#{id}", { content_entry: attributes })
        Resource.new(data)
      end

      private

      def endpoint(name = 'entries')
        "content_types/#{content_type.slug}/#{name}"
      end

    end

  end
end
