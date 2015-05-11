module Locomotive::Coal

  module Resources

    class ContentEntries < Base

      attr_accessor :content_type

      def initialize(uri, credentials, content_type)
        @content_type = content_type
        super(uri, credentials)
      end

      def index(query = nil, options = nil, locale = nil)
        parameters = { where: (query || {}).to_json }.merge(options || {})
        parameters[:_locale] = locale if locale

        response = get(resources_name, parameters, true)

        list = response.body.map { |attributes| Resource.new(attributes) }

        PaginatedResources.new(list,
          options[:page] || 1,
          response.headers[:x_total_pages].to_i,
          response.headers[:x_total_entries].to_i)
      end

      alias :all :index

      alias :update :update_with_locale

      private

      def resources_name
        "content_types/#{content_type.slug}/entries"
      end

    end

  end
end
