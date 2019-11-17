module Locomotive::Coal
  module Resources

    class Accounts < Base

      def index(query = nil, options = {})
        parameters = { where: (query || {}).to_json }.merge(options || {})

        response = get(resources_name, parameters, true)

        list = response.body.map { |attributes| Resource.new(attributes) }

        PaginatedResources.new(list,
          options[:page] || 1,
          response.headers[:x_total_pages].to_i,
          response.headers[:x_total_entries].to_i)
      end

      def each(query = nil, options = nil, &block)
        page = 1
        while page do
          resources = all(query, (options || {}).merge(page: page))
          resources.each(&block)
          page = resources._next_page
        end
      end

      alias :all :index

    end

  end
end
