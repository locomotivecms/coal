require 'json'

module Locomotive::Coal
  module Resources

    class Token < Struct.new(:uri, :credentials)

      include Concerns::Request

      def get
        JSON.parse(post('tokens', credentials))['token']
      end

    end

  end
end
