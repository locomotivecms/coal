module Locomotive::Coal
  module Resources

    class Memberships < Base

      def index
        get(resources_name).map do |attributes|
          Resource.new(attributes)
        end
      end

      
      alias :all :index

    end

  end
end
