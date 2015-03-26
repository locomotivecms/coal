module Locomotive::Coal

  class PaginatedResources < SimpleDelegator

    attr_accessor :_total_pages, :_total_entries

    def initialize(list, total_pages, total_entries)
      @_total_pages, @_total_entries  = total_pages, total_entries
      super(list)
    end

  end

end
