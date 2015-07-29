module Locomotive::Coal
  module Resources

    class Snippets < Base

      def index(locale = nil)
        get(resources_name, _locale: locale).map do |attributes|
          Resource.new(attributes)
        end
      end

      alias :all :index

    end

  end
end
