module Locomotive::Coal
  module Resources

    class Token < Struct.new(:uri, :credentials)

      include Locomotive::Coal::Request

      def get
        post('tokens', credentials)['token']
      end

    end

  end
end
