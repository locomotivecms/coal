module Locomotive::Coal

  class UploadIO < ::Faraday::UploadIO

    def initialize(filename_or_io, content_type = nil, filename = nil)
      super(filename_or_io, content_type || 'application/octet-stream', filename)
    end

  end

end
