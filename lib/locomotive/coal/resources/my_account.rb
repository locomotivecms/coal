module Locomotive::Coal
  module Resources

    class MyAccount < Struct.new(:uri, :token)

      include Locomotive::Coal::Request

      def get
        Resource.new(super('my_account'))
      end

    end

  end
end
