module Locomotive::Coal

  class UploadIO < ::Faraday::UploadIO

    def initialize(filename_or_io, content_type = nil, filename = nil)
      if filename.blank? && filename_or_io.is_a?(String)
        filename = File.basename(filename_or_io)
      end

      super(
        filename_or_io,
        content_type || MIME::Types.type_for(filename).first || 'application/octet-stream',
        filename
      )
    end

  end

end
