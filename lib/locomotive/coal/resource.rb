module Locomotive::Coal

  class Resource

    attr_accessor :attributes

    def initialize(attributes)
      @attributes = attributes
    end

    def method_missing(name, *args)
      if self.attributes.key?(name.to_s)
        self.attributes[name.to_s]
      else
        super
      end
    end

  end

end
