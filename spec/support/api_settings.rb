TEST_API_URI          = URI('http://localhost:3000/locomotive/api/v3').freeze
TEST_API_CREDENTIALS  = { email: 'john@doe.net', password: 'easyone' }.freeze

def api_token(uri = nil, credentials = nil)
  Locomotive::Coal::Resources::Token.new(uri || TEST_API_URI, credentials || TEST_API_CREDENTIALS.dup).get
end
