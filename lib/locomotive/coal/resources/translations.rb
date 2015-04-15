module Locomotive::Coal
  module Resources

    class Translations < Struct.new(:uri, :credentials)

      include Locomotive::Coal::Request

      def all
        get('translations').map do |attributes|
          Resource.new(attributes)
        end
      end

      def create(attributes = {})
        data = post('translations', { translation: attributes })
        Resource.new(data)
      end

      def update(id, attributes = {})
        data = put("translations/#{id}", { translation: attributes })
        Resource.new(data)
      end

      def destroy(id)
        data = delete("translations/#{id}")
        Resource.new(data)
      end

    end

  end
end
