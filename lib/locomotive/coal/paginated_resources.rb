module Locomotive::Coal

  class PaginatedResources < SimpleDelegator

    attr_accessor :_page, :_total_pages, :_total_entries

    def initialize(list, page, total_pages, total_entries)
      @_page, @_total_pages, @_total_entries = page, total_pages, total_entries
      super(list)
    end

    def _next_page
      if @_page < @_total_pages
        @_page + 1
      end
    end

  end

end
