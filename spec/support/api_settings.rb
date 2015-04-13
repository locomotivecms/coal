TEST_API_URI          = URI('http://localhost:3000').freeze
TEST_API_V3_URI       = URI('http://localhost:3000/locomotive/api/v3').freeze
TEST_API_EMAIL        = 'admin@locomotivecms.com'
TEST_API_CREDENTIALS  = { email: TEST_API_EMAIL, password: 'locomotive' }.freeze
TEST_API_CREDENTIALS_WITH_KEY = { email: TEST_API_EMAIL, api_key: 'd49cd50f6f0d2b163f48fc73cb249f0244c37074' }.freeze

def api_token(uri = nil, credentials = nil)
  Locomotive::Coal::Resources::Token.new(uri || TEST_API_V3_URI, credentials || TEST_API_CREDENTIALS.dup).get
end
