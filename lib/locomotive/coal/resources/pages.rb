module Locomotive::Coal
  module Resources

    class Pages < Base

      def index(locale)
        get(resources_name, _locale: locale).map do |attributes|
          Resource.new(attributes)
        end
      end

      alias :all :index

      def fullpaths(locale)
        get("#{resources_name}/fullpaths", _locale: locale).map do |attributes|
          Resource.new(attributes)
        end
      end

      alias :update :update_with_locale

    end

  end
end
