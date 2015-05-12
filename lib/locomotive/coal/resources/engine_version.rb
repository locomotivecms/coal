module Locomotive::Coal
  module Resources

    class EngineVersion < Base

      include Concerns::Request

      def version
        get('version', credentials)['engine']
      end

    end

  end
end
