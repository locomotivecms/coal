module Locomotive::Coal
  module Resources

    class Snippets < Struct.new(:uri, :credentials)

      include Locomotive::Coal::Request

      def all
        get('snippets').map do |attributes|
          Resource.new(attributes)
        end
      end

      def create(attributes = {})
        data = post('snippets', { snippet: attributes })
        Resource.new(data)
      end

      def update(id, attributes = {})
        data = put("snippets/#{id}", { snippet: attributes })
        Resource.new(data)
      end

      def destroy(id)
        data = delete("snippets/#{id}")
        Resource.new(data)
      end

    end

  end
end
