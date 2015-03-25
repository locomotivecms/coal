TEST_API_URI          = URI('http://sample.lvh.me:4000/locomotive/api').freeze
TEST_API_CREDENTIALS  = { email: 'john@doe.net', password: 'easyone' }.freeze

def api_token(uri = nil, credentials = nil)
  Locomotive::Coal::Resources::Token.new(uri || TEST_API_URI, credentials || TEST_API_CREDENTIALS.dup).get
end
