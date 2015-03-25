module Locomotive::Coal
  module Resources

    class Sites < Struct.new(:uri, :token)

      include Locomotive::Coal::Request

      def all
        get('sites').map do |attributes|
          Resource.new(attributes)
        end
      end

    end

  end
end
