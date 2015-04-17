require_relative 'concerns/request'

module Locomotive::Coal
  module Resources

    class Base

      include Concerns::Request

      attr_accessor :uri, :credentials

      def initialize(uri, credentials)
        @uri, @credentials = uri, credentials
      end

      def index
        get(resources_name).map do |attributes|
          Resource.new(attributes)
        end
      end

      alias :all :index

      def create(attributes = {})
        data = post(resources_name, { resource_name => attributes })
        Resource.new(data)
      end

      def update(id, attributes = {})
        data = put("#{resources_name}/#{id}", { resource_name => attributes })
        Resource.new(data)
      end

      def destroy(id)
        data = delete("#{resources_name}/#{id}")
        Resource.new(data)
      end

      private

      def resources_name
        resource_name.pluralize
      end

      def resource_name
        self.class.name.demodulize.downcase.singularize
      end

    end

  end
end
