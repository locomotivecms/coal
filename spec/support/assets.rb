def asset_io(filename)
  path = File.join(File.dirname(__FILE__), '..', 'fixtures', 'assets', filename)
  Locomotive::Coal::UploadIO.new(path)
end
