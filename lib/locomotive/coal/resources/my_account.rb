module Locomotive::Coal
  module Resources

    class MyAccount < Struct.new(:uri, :credentials)

      include Concerns::Request

      def get
        Resource.new(super('my_account'))
      end

      def create(attributes = {})
        without_authentication do
          data = post('my_account', account: attributes)
          Resource.new(data)
        end
      end

      def update(attributes = {})
        data = put('my_account', account: attributes)
        Resource.new(data)
      end

    end

  end
end
